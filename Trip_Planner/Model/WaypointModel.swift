//
//  WaypointModel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct Waypoint {
    let name: String
    let lng: Float
    let lat: Float
    
    init(name: String, longitude: Float, latitude: Float) {
        self.name = name
        self.lng = longitude
        self.lat = latitude
    }
}
