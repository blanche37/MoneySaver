//
//  SQLiteRepository.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation
import CoreData

class SQLiteRepository {
    func saveContext() {
        let context = CoreDataStack.shared.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchChallenge(completion: @escaping ([Challenge]) -> ()) {
        let context = CoreDataStack.shared.viewContext

        let fetchChallenge: NSFetchRequest<Challenge> = Challenge.fetchRequest()

        do {
            let challenge = try context.fetch(fetchChallenge)
            completion(challenge)
        } catch {
            print(error)
        }
    }
    
    func fetchConsumption(completion: @escaping ([Consumption]) -> ()) {
        let context = CoreDataStack.shared.viewContext

        let fetchConsumption: NSFetchRequest<Consumption> = Consumption.fetchRequest()

        do {
            let consumption = try context.fetch(fetchConsumption)
            completion(consumption)
        } catch {
            print(error)
        }
    }
    
    func removeAll() {
        let context = CoreDataStack.shared.viewContext
        
        let fetchChallenge = NSBatchDeleteRequest(fetchRequest: Challenge.fetchRequest())
        let fetchConsumption = NSBatchDeleteRequest(fetchRequest: Consumption.fetchRequest())
        
        do {
            try context.execute(fetchChallenge)
            try context.execute(fetchConsumption)
        } catch {
            print(error)
        }
    }
}
