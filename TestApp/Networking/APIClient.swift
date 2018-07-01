//
//  APIClient.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    // TODO: Handle error
    // Currently only set to return User type, could set to return any type specified
    static func request(endpoint: APIEndpoint, completion:@escaping ([User]?)->Void) {
        guard let url = URL(string: endpoint.fullURL) else {
            completion(nil)
            return
        }
        Alamofire.request(url).responseJSON { response in
            guard response.result.isSuccess else {
                    completion(nil)
                return
            }
            
            // init users with JSON
            guard let value = response.result.value as? [String: Any],
            let results = value["results"] as? [[String: Any]] else {
                print("Malformed data received from request")
                completion(nil)
                return
            }

            let users = results.compactMap{ json in return User(json: json) }
            completion(users)
        }
    }
}
