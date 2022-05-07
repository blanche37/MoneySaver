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
    func remove(challenge: Challenge)
    func update(challenge: Challenge, title: String, money: Int)
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
    
    func remove(challenge: Challenge) {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        
        guard let id = challenge.id else {
            return
        }
        
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", id as CVarArg)
        context.delete(challenge)
        save()
    }
    
    func update(challenge: Challenge, title: String, money: Int) {
        challenge.title = title
        challenge.money = Int64(money)
        
        save()
    }

}
