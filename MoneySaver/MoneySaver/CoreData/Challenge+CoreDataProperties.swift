//
//  Challenge+CoreDataProperties.swift
//  MoneySaver
//
//  Created by yun on 2022/05/07.
//
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var money: Int64
    @NSManaged public var period: Date?
    @NSManaged public var title: String?
    @NSManaged public var consumptions: NSSet?

}

// MARK: Generated accessors for consumptions
extension Challenge {

    @objc(addConsumptionsObject:)
    @NSManaged public func addToConsumptions(_ value: Consumption)

    @objc(removeConsumptionsObject:)
    @NSManaged public func removeFromConsumptions(_ value: Consumption)

    @objc(addConsumptions:)
    @NSManaged public func addToConsumptions(_ values: NSSet)

    @objc(removeConsumptions:)
    @NSManaged public func removeFromConsumptions(_ values: NSSet)

}

extension Challenge : Identifiable {

}
