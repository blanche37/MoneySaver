//
//  DateFormattable.swift
//  MoneySaver
//
//  Created by yun on 2022/05/08.
//

import Foundation

protocol DateFormattable {
}

extension DateFormattable {
    func changedDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/HH시까지"
        let convert = dateFormatter.string(from: date)
        
        return convert
    }
}

