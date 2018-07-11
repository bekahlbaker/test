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

    static func request(endpoint: APIEndpoint, completion:@escaping ([[String: Any]]?, Error?) -> Void) {
        guard let url = URL(string: endpoint.fullURL) else { return }
        
        Alamofire.request(url).responseJSON { response in
            guard response.result.isSuccess else {
                    let error = response.result.error
                    completion(nil, error)
                return
            }

            guard let value = response.result.value as? [String: Any],
            let results = value["results"] as? [[String: Any]] else {
                print("Malformed data received from request")
                completion(nil, response.result.error)
                return
            }

            completion(results, nil)
        }
    }
    
    static func downloadImage(with url: String, completion:@escaping (UIImage?) -> Void) {
        Alamofire.request(url).responseData { (response) in
            guard response.result.isSuccess else {
                completion(nil)
                return
            }
            
            guard let data = response.data,
                let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            completion(image)
        }
    }
}
