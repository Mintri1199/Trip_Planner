//
//  URLSessionMock.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

// Create a partial mock by subclassing the original class
class MockURLSessionDataTask: URLSessionDataTask {
    
    private let closure: () -> Void
    
    init (closure: @escaping () -> Void) {
        self.closure = closure
    }
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
