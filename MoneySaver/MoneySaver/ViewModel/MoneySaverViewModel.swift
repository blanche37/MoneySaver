//
//  ViewModel.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation
import CoreData

protocol ViewModel {
    var challenges: Observable<[NSManagedObject]> { get }
    var consumptions: Observable<[NSManagedObject]> { get }
    
    func add(item: NSManagedObject)
    func fetchChallenges()
    func fetchConsumptions()
}

final class MoneySaverViewModel: ViewModel {
    
}
