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
    let lng: Int?
    let lat: Int?
    
    init(name: String, longitude: Int?, latitude: Int?) {
        self.name = name
        self.lng = longitude
        self.lat = latitude
    }
}
