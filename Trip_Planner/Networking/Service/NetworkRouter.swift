//
//  NetworkRouter.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func  request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
