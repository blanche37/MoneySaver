//
//  AddItemViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/04.
//

import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
