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
    // MARK: - Properties
    var viewModel: ViewModel!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.readChallenges()
        tableView.reloadData()
    }
    
    // MARK: - IBActions
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

// MARK: - TableViewDelegate, TableViewDataSource
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(challenge: viewModel.challenges.value[indexPath.row])
            viewModel.challenges.value.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

// MARK: - TableViewRefresh
extension ListViewController: RefreshDelegate {
    func refresh() {
        tableView.reloadData()
    }
}

