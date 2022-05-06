//
//  ViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import UIKit

protocol RefreshDelegate: AnyObject {
    func refresh()
}

final class ListViewController: UIViewController {
    var viewModel: ViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
        tableView.reloadData()
    }
    
    @IBAction func presentAddItemViewController(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "AddItem", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "a") as? UINavigationController,
              let childVC = vc.viewControllers.first as? AddItemViewController else {
            return
        }
        
        childVC.viewModel = self.viewModel
        childVC.refreshDelegate = self
        self.present(vc, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.challenges.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? ConsumptionCell else {
            return UITableViewCell()
        }
        
        let challenge = viewModel.challenges.value[indexPath.row]
        
        guard let title = challenge.value(forKey: "title") as? String,
              let period = challenge.value(forKey: "period") as? Date,
              let money = challenge.value(forKey: "money") as? Int else {
            return UITableViewCell()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "~MM월dd일HH시"
        let convert = dateFormatter.string(from: period)
        
        cell.bind(title: title, period: convert, money: money)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        cell.isSelected = false
    }
}

extension ListViewController: RefreshDelegate {
    func refresh() {
        tableView.reloadData()
    }
}

