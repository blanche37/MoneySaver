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
    func removeAll(completion: @escaping () -> ())
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
    
    func removeAll(completion: @escaping () -> ()) {
        repository.removeAll()
        completion()
    }

    init(repository: Repository) {
        self.repository = repository
    }
}
