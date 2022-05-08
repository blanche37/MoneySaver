//
//  ViewModel.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation
import CoreData

protocol ViewModel {
    var challenges: Observable<[Challenge]> { get }
    var consumptions: Observable<[Consumption]> { get }
    
    func create(item: NSManagedObject)
    func readChallenges()
    func update(challenge: Challenge, title: String, money: Double)
    func delete(challenge: Challenge)
}

final class MoneySaverViewModel: ViewModel {
    // MARK: - Properties
    var service: Service!
    var challenges = Observable<[Challenge]>([])
    var consumptions = Observable<[Consumption]>([])
    
    // MARK: - Methods
    func create(item: NSManagedObject) {
        if let challenge = item as? Challenge {
            challenges.value.append(challenge)
        } else if let consumption = item as? Consumption {
            consumptions.value.append(consumption)
        }
        service.save()
    }
    
    func readChallenges() {
        service.read { [weak self] challenges in
            guard let self = self else {
                return
            }
            
            self.challenges.value = challenges
        }
    }
    
    func update(challenge: Challenge, title: String, money: Double) {
        service.update(challenge: challenge, title: title, money: money)
    }
    
    func delete(challenge: Challenge) {
        service.delete(challenge: challenge)
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
    
    // MARK: - Initializer
    init(service: Service) {
        self.service = service
    }
}
