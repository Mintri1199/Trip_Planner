//
//  TripPersistent+CoreDataProperties.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/9/19.
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
    @NSManaged public var waypoint: NSSet?

}

// MARK: Generated accessors for waypoint
extension TripPersistent {

    @objc(addWaypointObject:)
    @NSManaged public func addToWaypoint(_ value: WaypointPersistent)

    @objc(removeWaypointObject:)
    @NSManaged public func removeFromWaypoint(_ value: WaypointPersistent)

    @objc(addWaypoint:)
    @NSManaged public func addToWaypoint(_ values: NSSet)

    @objc(removeWaypoint:)
    @NSManaged public func removeFromWaypoint(_ values: NSSet)

}
