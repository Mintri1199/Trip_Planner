//
//  NetworkManager.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    private let googleMapRouter = Router<GooglePlacesApi>()
    private let geocodeRouter = Router<GeocoderApi>()
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
    
    // Get API key for google map platform
    func getAPIKey(_ completion: @escaping(String) -> Void) {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var data: [String: AnyObject] = [:]
        let path: String? = Bundle.main.path(forResource: "Info", ofType: "plist")
        let xmlContents = FileManager.default.contents(atPath: path!)
        
        do {
            if let xmlContents = xmlContents {
                
                data = try (PropertyListSerialization.propertyList(from:xmlContents, options:.mutableContainersAndLeaves, format:&format) as? [String:AnyObject] ?? ["Error":"Error" as AnyObject])
                
                if let apiKey = data["API_KEY"] as? String {
                    completion(apiKey)
                } else {
                    print("API key is not String, ill config")
                }
            }
        } catch {
            print("Can not read Info.plist: \(error)")
        }
    }
    // Get app id and code for geocoder
    func getAppIdAndCode(_ completion: @escaping((String, String)) -> Void) {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var data: [String: AnyObject] = [:]
        let path: String? = Bundle.main.path(forResource: "Info", ofType: "plist")
        let xmlContents = FileManager.default.contents(atPath: path!)
        
        do {
            if let xmlContents = xmlContents {
                data = try (PropertyListSerialization.propertyList(from:xmlContents, options: .mutableContainersAndLeaves, format:&format) as? [String: AnyObject] ?? ["Error": "Error" as AnyObject])
                
                if let appId = data["App Id"] as? String , let appCode = data["App Code"] as? String{
                    let idAndCode = (appId, appCode)
                    completion(idAndCode)
                } else {
                    print("App id or code is not String, ill config")
                }
            }
        } catch {
            print("Can not read Info.plist: \(error)")
        }
    }
    
    func getAutoCompleteResult(input: String, key: String, completion: @escaping (Result<[String], NetworkReponse>) -> Void) {
        googleMapRouter.request(.autoComplete(input: input, key: key)) { (data, response, error) in
            if error != nil {
                print("Check your network connection")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.newHandleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data  else { completion(.failure(.noData)); return }
                    
                    do {
                        let apiResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any]
                        
                        // Access the prediction array in from the json
                        if let predictionArray = apiResponse!["predictions"] as? [[String: Any]] {
                            var arrayOfAddresses: [String] = []
                            // Loop through the prediction array and append the address array with newly instantiated Waypoint model
                            for item in predictionArray {
                                if let address = item["description"] as? String {
                                    
                                    arrayOfAddresses.append(address)
                                }
                            }
                            // Later if there's time, add a no data error handling state
                            if !arrayOfAddresses.isEmpty {
                                completion(.success(arrayOfAddresses))
                            } else {
                                completion(.failure(.noData))
                            }
                        }
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
    
    func getGeocode(address: String, completion: @escaping (Result<JSONResponse, NetworkReponse>) -> Void) {
        self.getAppIdAndCode { (result) in
            self.geocodeRouter.request(.geocodeOnePlace(address: address, appId: result.0, appCode: result.1), completion: { (data, response, error) in
                if error != nil {
                    print("Check your network connection")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.newHandleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data  else { completion(.failure(.noData)); return }
                        
                        do {
                            let parsedJson = try JSONDecoder().decode(JSONResponse.self, from: responseData)
                            completion(.success(parsedJson))
                        } catch {
                            completion(.failure(.unableToDecode))
                        }
                    case .failure(let networkFailureError):
                        completion(.failure(networkFailureError))
                    }
                }
            })
        }
    }
}
