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
    func update(challenge: Challenge, title: String, money: Int)
    func removeAll(completion: @escaping () -> ())
    func delete(challenge: Challenge)
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
    
    func update(challenge: Challenge, title: String, money: Int) {
        repository.update(challenge: challenge, title: title, money: money)
    }
    
    func delete(challenge: Challenge) {
        repository.remove(challenge: challenge)
    }
    
    func removeAll(completion: @escaping () -> ()) {
        repository.removeAll()
        completion()
    }

    init(repository: Repository) {
        self.repository = repository
    }
}
