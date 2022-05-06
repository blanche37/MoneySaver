//
//  AddItemViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/04.
//

import UIKit
import CoreData

final class AddItemViewController: UIViewController {
    var viewModel: ViewModel!
    weak var refreshDelegate: RefreshDelegate!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
    
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
    
    @IBAction func addItem(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true) { [weak self] in
            guard let self = self,
                  let currency = self.currencySegmentedControl.titleForSegment(at: self.currencySegmentedControl.selectedSegmentIndex),
                  let expiration = self.periodSegmentedControl.titleForSegment(at: self.periodSegmentedControl.selectedSegmentIndex),
                  let title = self.titleTextField.text,
                  let money = self.moneyTextField.text.flatMap({Int($0)}) else {
                return
            }
    
            let context = CoreDataStack.shared.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Challenge", in: context)
            
            if let entity = entity {
                let challenge = NSManagedObject(entity: entity, insertInto: context)
                let expire: Date = self.expiration(expiration: expiration)
                challenge.setValue(title, forKey: "title")
                challenge.setValue(expire, forKey: "period")
                challenge.setValue(money, forKey: "money")
                challenge.setValue(UUID(), forKey: "id")
                
                self.viewModel.create(item: challenge)
                self.refreshDelegate.refresh()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawUnderline(textFields: [titleTextField, moneyTextField])
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
}
