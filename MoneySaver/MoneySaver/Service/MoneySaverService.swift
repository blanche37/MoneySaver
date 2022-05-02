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

final class MoneySaverService: Service {
    var repository: Repository!
    
    func save() {
        repository.save()
    }
    
    func fetch(completion: @escaping ([Challenge]) -> ()) {
        repository.fetch { challenges in
            completion(challenges)
        }
    }
    
    func fetch(completion: @escaping ([Consumption]) -> ()) {
        repository.fetch { consumptions in
            completion(consumptions)
        }
    }
    
    func removeAll() {
        repository.removeAll()
    }

    init(repository: Repository) {
        self.repository = repository
    }
}
