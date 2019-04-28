//
//  WaypointViewModel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct WaypointViewModel {
    let name: String
    
    // Dependency Injection (DI)
    init(waypoint: Waypoint){
        self.name = waypoint.name
    }
}
