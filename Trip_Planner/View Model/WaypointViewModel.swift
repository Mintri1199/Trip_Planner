//
//  WaypointViewModel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import MapKit

// Waypoint view model for the trip detail table view
struct WaypointViewModel {
    let name: String
    // Dependency Injection (DI)
    init(wayPoint: WaypointPersistent){
        self.name = wayPoint.name!
    }
}

// The pin for the map view 
class MapViewViewModel: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(wayPoint: Waypoint) {
        self.title = wayPoint.name
        self.coordinate = CLLocationCoordinate2D(latitude: wayPoint.lat, longitude: wayPoint.lng)
        
        super.init()
    }

}
