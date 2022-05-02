//
//  SQLiteRepository.swift
//  MoneySaver
//
//  Created by yun on 2022/05/02.
//

import Foundation

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
}
