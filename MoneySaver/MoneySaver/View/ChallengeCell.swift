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

extension ChallengeCell: NumberFormattable, DateFormattable {
    func bind(title: String, period: Date, money: Double, currency: String) {
        let changedNumber = changeNumberFormat(currency: currency, number: money)
        let changedPeriod = changedDateFormat(date: period)
        itemLabel.text = title
        priceLabel.text = changedNumber
        dateLabel.text = changedPeriod
    }
}

