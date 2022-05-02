//
//  MoneySaverService.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation
import CoreData

protocol Service {
    func save()
    func fetch(completion: @escaping ([Challenge]) -> ())
    func fetch(completion: @escaping ([Consumption]) -> ())
    func removeAll()
}

class MoneySaverService: Service {
    
}
