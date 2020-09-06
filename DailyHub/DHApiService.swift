    //
    //  DHApiService.swift
    //  DailyHub
    //
    //  Created by Karthi on 07/06/20.
    //  Copyright © 2020 Karthi. All rights reserved.
    //
    
    import Foundation
    
    enum APIError: Error {
        case urlError(description: String?)
        case serializationError(description: String?)
    }
    
    class DHApiService : NSObject {
        
        // Fetch Data from api
        static func fetchData <T> (requestUrl: URLRequest?, resultStruct: T.Type, completion: @escaping((Any?, Error?) -> ())) where T : Decodable {
            guard let _ = requestUrl, let url = requestUrl?.url else {
                completion(nil, APIError.urlError(description: "Invalid Url"))
                return
            }
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(nil, APIError.serializationError(description: "No data found in reponse"))
                    return
                }
                do {
                    let decodedJson = try JSONDecoder().decode(resultStruct, from: data)
                    DispatchQueue.main.async {
                        completion(decodedJson, nil)
                    }
                } catch {
                    completion(nil, APIError.serializationError(description: error as? String))
                    print("ERROR \(error)");
                }
                
            }
            dataTask.resume()
            
        }
        
        // Fetch data from bundle
        static func fetchDataFromBundle<T> (resourceName: String, resultStruct: T.Type, completion: @escaping((Any?, Error?) -> ())) where T : Decodable {
               if let url = Bundle.main.url(forResource: resourceName, withExtension: "json") {
                   do {
                       let data = try Data(contentsOf: url)
                       let decodedJson = try JSONDecoder().decode(resultStruct, from: data)
                       completion(decodedJson, nil)
                   } catch {
                       print("ERROR IN FETCHING FROM BUNDLE", error)
                    completion(nil, error)
                   }
               }
           }
        
    }
