//
//  WaypointPersitent+CoreDataProperties.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//
//

import Foundation
import CoreData


extension WaypointPersistent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaypointPersistent> {
        return NSFetchRequest<WaypointPersistent>(entityName: "WaypointPersitent")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var waypoint: TripPersistent?

}
