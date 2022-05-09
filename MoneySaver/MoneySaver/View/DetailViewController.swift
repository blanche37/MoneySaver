//
//  DetailViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/09.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func presentAddItemViewController(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "AddItem", bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: "a") as? UINavigationController,
              let childVC = vc.viewControllers.first as? AddItemViewController else {
            return
        }
        
        childVC.title = "Update"
        childVC.viewModel = viewModel
        self.present(vc, animated: true)
    }
}
