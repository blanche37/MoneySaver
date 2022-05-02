//
//  Observable.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation

final class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
