//
//  MockRequestEncoder.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

public typealias MockParameters = [String: Any]

public protocol MockParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: MockParameters) throws
}

public enum MockNetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters encoding failed."
    case missingURL = "URL is nil"
}

public struct MockURLParameterEncoder: MockParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: MockParameters) throws {
        guard let url = urlRequest.url else { throw MockNetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

public struct MockJSONParameterEncoder: MockParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: MockParameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw MockNetworkError.encodingFailed
        }
    }
}
