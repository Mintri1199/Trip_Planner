//
//  TripPersistent+CoreDataProperties.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//
//

import Foundation
import CoreData


extension TripPersistent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripPersistent> {
        return NSFetchRequest<TripPersistent>(entityName: "TripPersistent")
    }

    @NSManaged public var name: String?
    @NSManaged public var waypoints: NSObject?
    @NSManaged public var trip: NSSet?

}

// MARK: Generated accessors for trip
extension TripPersistent {

    @objc(addTripObject:)
    @NSManaged public func addToTrip(_ value: WaypointPersitent)

    @objc(removeTripObject:)
    @NSManaged public func removeFromTrip(_ value: WaypointPersitent)

    @objc(addTrip:)
    @NSManaged public func addToTrip(_ values: NSSet)

    @objc(removeTrip:)
    @NSManaged public func removeFromTrip(_ values: NSSet)

}
