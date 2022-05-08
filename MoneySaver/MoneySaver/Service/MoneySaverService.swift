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
    func read(completion: @escaping ([Challenge]) -> ())
    func update(challenge: Challenge, title: String, money: Double)
    func delete(challenge: Challenge)
    func removeAll(completion: @escaping () -> ())
}

final class MoneySaverService: Service {
    // MARK: - Properties
    var repository: Repository!
    
    // MARK: - Methods
    func save() {
        repository.save()
    }
    
    func read(completion: @escaping ([Challenge]) -> ()) {
        repository.read { challenges in
            completion(challenges)
        }
    }
    
    func update(challenge: Challenge, title: String, money: Double) {
        repository.update(challenge: challenge, title: title, money: money)
    }
    
    func delete(challenge: Challenge) {
        repository.delete(challenge: challenge)
    }
    
    func removeAll(completion: @escaping () -> ()) {
        repository.removeAll()
        completion()
    }

    // MARK: - Initializer
    init(repository: Repository) {
        self.repository = repository
    }
}
