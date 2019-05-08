//
//  TripModel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct Trip{
    
    let name: String
    var wayPoints: [Waypoint]?
    
    init(name: String) {
        self.name = name
    }
}
