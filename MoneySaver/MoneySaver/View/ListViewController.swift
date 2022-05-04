//
//  ViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import UIKit

final class ListViewController: UIViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        title = "Challenges"
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func addItem() {
        
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? ConsumptionCell else {
            return UITableViewCell()
        }
        
        cell.itemLabel.text = "yun"
        cell.priceLabel.text = "28"
        cell.dateLabel.text = "\(Date())"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

