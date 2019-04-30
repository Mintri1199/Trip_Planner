//
//  EndPointTypeProtocol.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
