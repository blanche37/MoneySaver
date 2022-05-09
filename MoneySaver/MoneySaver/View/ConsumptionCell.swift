//
//  ConsumptionCell.swift
//  MoneySaver
//
//  Created by yun on 2022/05/09.
//

import UIKit

class ConsumptionCell: UITableViewCell {
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
}

extension ConsumptionCell: NumberFormattable, DateFormattable {
    func bind(item: String, price: Double, date: Date, currency: String) {
        let convertedPrice = changeNumberFormat(currency: currency, number: price)
        let convertedDate = changedDateFormat(date: date)
        itemLabel.text = item
        priceLabel.text = convertedPrice
        dateLabel.text = convertedDate
    }
}
