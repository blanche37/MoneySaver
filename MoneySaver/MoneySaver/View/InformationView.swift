//
//  InformationView.swift
//  MoneySaver
//
//  Created by yun on 2022/05/09.
//

import UIKit

@IBDesignable
class InformationView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
}
