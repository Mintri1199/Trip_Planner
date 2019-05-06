//
//  GeocoderEndpoint.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/6/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public enum GeocoderApi {
    case geocodeOnePlace(address: String, appId: String, appCode: String)
}

extension GeocoderApi: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production:
            return "https://geocoder.api.here.com/6.2"
        case .qa:
            return "none"
        case .staging:
            return "none"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configure") }
        return url
    }
    
    var path: String {
        switch self {
        case .geocodeOnePlace:
            return "/geocode.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .geocodeOnePlace(address: let address, appId: let appId, appCode: let appCode):
            return .requestParameter(bodyParameters: nil, urlParameters: ["searchtext": address, "app_id": appId, "app_code": appCode])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil 
    }
}
