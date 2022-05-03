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
    func fetchChallenges(completion: @escaping ([Challenge]) -> ())
    func fetchConsumptions(completion: @escaping ([Consumption]) -> ())
    func removeAll(completion: @escaping () -> ())
}

final class MoneySaverService: Service {
    var repository: Repository!
    
    func save() {
        repository.save()
    }
    
    func fetchChallenges(completion: @escaping ([Challenge]) -> ()) {
        repository.fetch { challenges in
            completion(challenges)
        }
    }
    
    func fetchConsumptions(completion: @escaping ([Consumption]) -> ()) {
        repository.fetch { consumptions in
            completion(consumptions)
        }
    }
    
    func removeAll(completion: @escaping () -> ()) {
        repository.removeAll()
        completion()
    }

    init(repository: Repository) {
        self.repository = repository
    }
}
