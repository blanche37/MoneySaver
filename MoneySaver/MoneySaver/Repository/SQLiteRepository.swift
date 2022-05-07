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
    func read(completion: @escaping ([Challenge]) -> ())
    func update(challenge: Challenge, title: String, money: Double)
    func delete(challenge: Challenge)
    func removeAll()
}

final class SQLiteRepository: Repository {
    func save() {
        let context = CoreDataStack.shared
        
        context.saveContext()
    }
    
    func read(completion: @escaping ([Challenge]) -> ()) {
        let context = CoreDataStack.shared.viewContext

        let fetchChallenge: NSFetchRequest<Challenge> = Challenge.fetchRequest()

        do {
            let challenge = try context.fetch(fetchChallenge)
            completion(challenge)
        } catch {
            print(error)
        }
    }
    
    func update(challenge: Challenge, title: String, money: Double) {
        challenge.title = title
        challenge.money = money
        
        save()
    }
    
    func delete(challenge: Challenge) {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        
        guard let id = challenge.id else {
            return
        }
        
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", id as CVarArg)
        context.delete(challenge)
        save()
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
}
