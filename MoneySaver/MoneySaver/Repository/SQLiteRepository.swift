//
//  SQLiteRepository.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation
import CoreData

protocol Repository {
    func save()
    func fetch(completion: @escaping ([Challenge]) -> ())
    func removeChallenge()
    func removeConsumption()
    func updateChallenge()
    func updateConsumption()
    func removeAll()
}

final class SQLiteRepository: Repository {
    func save() {
        let context = CoreDataStack.shared
        
        context.saveContext()
    }
    
    func fetch(completion: @escaping ([Challenge]) -> ()) {
        let context = CoreDataStack.shared.viewContext

        let fetchChallenge: NSFetchRequest<Challenge> = Challenge.fetchRequest()

        do {
            let challenge = try context.fetch(fetchChallenge)
            completion(challenge)
        } catch {
            print(error)
        }
    }
    
    func removeAll() {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest = NSBatchDeleteRequest(fetchRequest: Challenge.fetchRequest())
        
        do {
            try context.execute(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    func removeChallenge() {
        
    }
    
    func removeConsumption() {
        
    }
    
    func updateChallenge() {
        
    }
    
    func updateConsumption() {
        
    }
}
