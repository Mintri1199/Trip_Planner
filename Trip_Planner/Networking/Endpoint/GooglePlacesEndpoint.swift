//
//  GooglePlacesEndpoint.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum GooglePlacesApi {
    case autoComplete(input: String, key: String) // Get an autocomplete response of places for search
    case getOnePlace(input: String, key: String)  // Get the address and coordinates of one place
    case getPlaces    // Get the coordinates and addresses of multiple places
}

extension GooglePlacesApi: EndPointType {
//    https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphitheatre&key=<API_KEY>&sessiontoken=1234567890

    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production:
            return "https://maps.googleapis.com/maps/api/place"
        case .qa:
            return "https://maps.googleapis.com/maps/api/place"
        case .staging:
            return "https://maps.googleapis.com/maps/api/place"
        }
    }
        
        var baseURL: URL {
            guard let url = URL(string: environmentBaseURL) else { fatalError("BaseURL could not be configure") }
            return url
        }
        
        var path: String {
            switch self {
            case .autoComplete:
                return "/autocomplete/json"
            case .getOnePlace:
                return "/textsearch/json"
            case .getPlaces:
                return "wow"
            }
        }
        
        var httpMethod: HTTPMethod {
            return .get
        }
        
        var task: HTTPTask {
            switch self {
            case .autoComplete(input: let input, key: let key):
                return .requestParameter(bodyParameters: nil, urlParameters: ["input" : input, "key" : key])
                
            case .getOnePlace(input: let input, key: let key):
                return .requestParameter(bodyParameters: nil, urlParameters: ["input" : input, "key" : key])
            default:
                return .request
            }
        }
        
        var headers: HTTPHeaders? {
            return nil
        }
}
