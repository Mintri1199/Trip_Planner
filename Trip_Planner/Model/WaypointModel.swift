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
    let lng: Double
    let lat: Double
    
    init(jsonresult: JSONResponse){
        print(jsonresult)
        self.name = jsonresult.response.view[0].result[0].location.address.label  // Holy what the heck
        self.lng = jsonresult.response.view[0].result[0].location.displayPosition.longitude
        self.lat = jsonresult.response.view[0].result[0].location.displayPosition.latitude
    }
}
