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
    @IBOutlet weak var middleView: InformationView!
    @IBOutlet weak var bottomView: InformationView!
    @IBOutlet weak var middleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 13
        let deviceHeight = UIScreen.main.bounds.height
        middleHeightConstraint.constant = deviceHeight / 4 * 3
        bottomHeightConstraint.constant = middleView.bounds.height / 4 * 3
        bottomView.isHidden = true
        
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
    
    @IBAction func foldMiddleView(_ sender: UIButton) {
        let deviceHeight = UIScreen.main.bounds.height
        
        if middleHeightConstraint.constant == 0 {
            bottomHeightConstraint.constant = middleView.bounds.height / 4 * 3
            middleHeightConstraint.constant = deviceHeight / 4 * 3
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                self.bottomView.isHidden = true
            }

        } else {
            bottomView.isHidden = false
            middleHeightConstraint.constant = 0
            bottomHeightConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}
