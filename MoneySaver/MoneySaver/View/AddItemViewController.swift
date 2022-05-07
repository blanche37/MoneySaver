//
//  AddItemViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/04.
//

import UIKit
import CoreData

extension Notification.Name {
    static let checkTextField = Notification.Name("checkTextField")
}

final class AddItemViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ViewModel!
    weak var refreshDelegate: RefreshDelegate!
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var moneyTextField: UITextField!
    @IBOutlet private weak var currencySegmentedControl: UISegmentedControl!
    @IBOutlet private weak var periodSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var doneButton: UIButton!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        drawUnderline(textFields: [titleTextField, moneyTextField])
        changeSegmentedControlFontColor()
        setPlaceholderColor(textFields: [titleTextField, moneyTextField], .lightGray)
        titleTextField.becomeFirstResponder()
        doneButton.isEnabled = false
        addObservers(notificationName: Notification.Name.checkTextField)
    }
    
    // MARK: - IBActions
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true) { [weak self] in
            guard let self = self,
                  let currency = self.currencySegmentedControl.titleForSegment(at: self.currencySegmentedControl.selectedSegmentIndex),
                  let expiration = self.periodSegmentedControl.titleForSegment(at: self.periodSegmentedControl.selectedSegmentIndex),
                  let title = self.titleTextField.text,
                  let money = self.moneyTextField.text.flatMap({Int($0)}) else {
                return
            }

            let expire: Date = self.expiration(expiration: expiration)
            let challenge = Challenge(context: CoreDataStack.shared.viewContext)
            challenge.setValue(title, forKey: "title")
            challenge.setValue(expire, forKey: "period")
            challenge.setValue(money, forKey: "money")
            challenge.setValue(UUID(), forKey: "id")
            self.viewModel.create(item: challenge)
            self.refreshDelegate.refresh()
        }
    }
    
    @IBAction func checkTitleTextField(_ sender: UITextField) {
        postNotification(notificationName: Notification.Name.checkTextField)
    }
    
    @IBAction func checkMoneyTextField(_ sender: UITextField) {
        postNotification(notificationName: Notification.Name.checkTextField)
    }
    
    // MARK: - Methods
    private func expiration(expiration: String) -> Date {
        switch expiration {
        case "1Day":
            return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        case "7Days":
            return Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        case "30Days":
            return Calendar.current.date(byAdding: .day, value: 30, to: Date())!
        default:
            fatalError()
        }
    }
    
    private func drawUnderline(textFields: [UITextField]) {
        textFields.forEach {
            let border = CALayer()
            let width = CGFloat(0.5)
            border.borderColor = UIColor(named: "MyWhite")?.cgColor
            border.frame = CGRect(x: 0, y: $0.frame.size.height - width, width: $0.frame.size.width, height: $0.frame.size.height)
            border.borderWidth = width
            $0.layer.addSublayer(border)
            $0.layer.masksToBounds = true
        }
    }
    
    private func changeSegmentedControlFontColor() {
        [currencySegmentedControl, periodSegmentedControl].forEach {
            $0?.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
    }
    
    private func setPlaceholderColor(textFields: [UITextField], _ placeholderColor: UIColor) {
        textFields.forEach {
            $0.attributedPlaceholder = NSAttributedString(
                string: $0.placeholder ?? "",
                attributes: [
                    .foregroundColor: placeholderColor,
                    .font: $0.font
                ].compactMapValues { $0 }
            )
        }
    }
    
    private func addObservers(notificationName: Notification.Name) {
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: notificationName, object: nil)
    }
    
    private func postNotification(notificationName: Notification.Name) {
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    @objc func checkTextField() {
        if let _ = moneyTextField.text.flatMap({Int($0)}),
           titleTextField.hasText {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - TextFieldDelegate
extension AddItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 9
    }
}
