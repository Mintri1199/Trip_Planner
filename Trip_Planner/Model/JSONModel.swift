//
//  JSONModel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct JSONResponse: Codable {
    let response: Response
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

struct Response: Codable {
    let view: [View]
    
    enum CodingKeys: String, CodingKey {
        case view = "View"
    }
}

struct View: Codable {
    let result: [JSONResult]
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

struct JSONResult: Codable {
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case location = "Location"
    }
}

struct Location: Codable {
    let displayPosition: DisplayPosition
    let address: Address
    
    enum CodingKeys: String, CodingKey {
        case displayPosition = "DisplayPosition"
        case address = "Address"
    }
}

struct Address: Codable {
    let label: String
    
    enum CodingKeys: String, CodingKey {
        case label = "Label"
    }
}

struct DisplayPosition: Codable {
    let latitude, longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}
