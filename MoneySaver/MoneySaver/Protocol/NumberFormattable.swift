//
//  NumberFormattable.swift
//  MoneySaver
//
//  Created by yun on 2022/05/08.
//

import Foundation

protocol NumberFormattable {
}

extension NumberFormattable {
    func changeNumberFormat(currency: String, number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let changedNumber = numberFormatter.string(for: number) else {
            return ""
        }
        
        return "\(currency) \(changedNumber)"
    }
}
