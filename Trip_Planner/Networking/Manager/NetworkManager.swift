//
//  NetworkManager.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let environment: NetworkEnvironment = .production
    
    enum NetworkReponse: String, Error {
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }
    
    fileprivate func newHandleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkReponse> {
        switch response.statusCode {
        case 200...299: return Result.success("Success")
        case 401...500: return Result.failure(.authenticationError)
        case 501...599: return Result.failure(.badRequest)
        case 600: return Result.failure(.outdated)
        default: return Result.failure(.failed)
        }
    }
    
    // Example of how to create a network call
//    func newGetKeywords(completion: @escaping (Result<[Keyword], NetworkReponse>) -> Void) {
//
//        keywordRouter.request(.keywords) { (data, response, error) in
//
//            if error != nil {
//                print("Check your network connection")
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.newHandleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data  else { completion(.failure(.noData)); return }
//
//                    do {
//                        let apiResponse = try JSONDecoder().decode([Keyword].self, from: responseData)
//                        completion(.success(apiResponse))
//                    } catch {
//                        completion(.failure(.unableToDecode))
//                    }
//                case .failure(let networkFailureError):
//                    completion(.failure(networkFailureError))
//                }
//            }
//        }
//    }
}
