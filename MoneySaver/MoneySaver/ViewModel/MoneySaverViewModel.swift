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
    
    func create(item: NSManagedObject)
    func fetch()
}

final class MoneySaverViewModel: ViewModel {
    var service: Service!
    
    var challenges = Observable<[NSManagedObject]>([])
    var consumptions = Observable<[NSManagedObject]>([])
    
    func create(item: NSManagedObject) {
        if item is Challenge {
            challenges.value.append(item)
        } else {
            consumptions.value.append(item)
        }
        service.save()
    }
    
    func fetch() {
        service.fetch { [weak self] challenges in
            guard let self = self else {
                return
            }
            
            self.challenges.value = challenges
        }
    }
    
    func removeAll() {
        service.removeAll { [weak self] in
            guard let self = self else {
                return
            }
            
            self.challenges.value = []
            self.consumptions.value = []
        }
    }
    
    init(service: Service) {
        self.service = service
    }
}
