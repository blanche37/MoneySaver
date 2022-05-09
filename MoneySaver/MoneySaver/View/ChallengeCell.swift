//
//  ConsumptionCell.swift
//  MoneySaver
//
//  Created by yun on 2022/05/04.
//

import UIKit

class ChallengeCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
}

extension ChallengeCell: NumberFormattable {
    func bind(title: String, period: String, money: Double, currency: String) {
        let changedNumber = changeNumberFormat(currency: currency, number: money)
        itemLabel.text = title
        priceLabel.text = changedNumber
        dateLabel.text = period
    }
}

