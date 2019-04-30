//
//  HTTPTask.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameter(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    
    // case download, upload ... etc
}
