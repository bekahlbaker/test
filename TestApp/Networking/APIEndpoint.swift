//
//  APIEndpoint.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var fullURL: String { get }
    // Could add method/parameters/encoding/headers if needed
}

extension APIEndpoint {
    
    var baseURL: String {
        return "https://randomuser.me/api/"
    }
    
    var fullURL: String {
        return baseURL + path
    }
}

enum UsersEndpoints {
    case getUsers(countOf: Int)
    // Could add additional user endpoints (login, get specific user, etc)
}

extension UsersEndpoints: APIEndpoint {

    var path: String {
        switch self {
        case .getUsers(let countOf):
            return "?results=\(countOf)"
        }
    }
}
