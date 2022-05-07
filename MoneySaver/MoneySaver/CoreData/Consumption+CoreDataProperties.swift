//
//  Consumption+CoreDataProperties.swift
//  MoneySaver
//
//  Created by yun on 2022/05/07.
//
//

import Foundation
import CoreData


extension Consumption {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Consumption> {
        return NSFetchRequest<Consumption>(entityName: "Consumption")
    }

    @NSManaged public var date: Date?
    @NSManaged public var item: String?
    @NSManaged public var price: Int64

}

extension Consumption : Identifiable {

}
