//
//  ConsumptionCell.swift
//  MoneySaver
//
//  Created by yun on 2022/05/04.
//

import UIKit

class ConsumptionCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func bind(title: String, period: String, money: Int) {
        itemLabel.text = title
        priceLabel.text = "\(money)"
        dateLabel.text = period
    }
}

