//
//  ViewController.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import UIKit
import CoreData

final class ListViewController: UIViewController {
    lazy var viewModel: ViewModel = MoneySaverViewModel(service: service)
    lazy var service: Service = MoneySaverService(repository: repository)
    var repository: Repository = SQLiteRepository()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "기간을 선택하세요.", message: nil, preferredStyle: .actionSheet)
        
        let month = UIAlertAction(title: "30 Days", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let date = Date()
            if let expiration = Calendar.current.date(byAdding: .day, value: 30, to: date) {
                self.presentAlertForChallenge(expiration: expiration)
            }
        }
        
        let week = UIAlertAction(title: "7 Days", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let date = Date()
            if let expiration = Calendar.current.date(byAdding: .day, value: 7, to: date) {
                self.presentAlertForChallenge(expiration: expiration)
            }
        }
        
        let day = UIAlertAction(title: "1 Day", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let date = Date()
            if let expiration = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                self.presentAlertForChallenge(expiration: expiration)
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        
        [month, week, day, cancel].forEach { actionSheet.addAction($0) }
        
        present(actionSheet, animated: true)
    }
    
    private func presentAlertForChallenge(expiration: Date) {
        let alert = UIAlertController(title: "목표를 입력하세요.", message: nil, preferredStyle: .alert)
        
        let submit = UIAlertAction(title: "submit", style: .default) { [weak self] _ in
            
            guard let self = self,
                  let title = alert.textFields?.first?.text,
                  let money = alert.textFields?.last?.text.flatMap({Int($0)}) else {
                return
            }
            
            let context = CoreDataStack.shared.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Challenge", in: context)
            
            if let entity = entity {
                let challenge = NSManagedObject(entity: entity, insertInto: context)
                challenge.setValue(title, forKey: "title")
                challenge.setValue(expiration, forKey: "period")
                challenge.setValue(money, forKey: "money")
                
                self.viewModel.challenges.value.append(challenge)
                do {
                    try context.save()
                    self.tableView.reloadData()
                    print(self.viewModel.challenges)
                } catch {
                    print(error)
                }
            }
            

        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addTextField {
            $0.placeholder = "목표를 입력하세요."
        }
        
        alert.addTextField {
            $0.placeholder = "목표금액을 입력하세요."
        }
        
        [submit, cancel].forEach { alert.addAction($0) }
        present(alert, animated: true)
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
}

