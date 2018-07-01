//
//  UserEndpoints.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import Foundation

enum UserEndpoints {
    case getUsers(countOf: Int)
    // Could add additional user endpoints (login, get specific user, etc)
}

extension UserEndpoints: APIEndpoint {
    var baseURL: String {
        return "https://randomuser.me/api/"
    }
    
    var path: String {
        switch self {
        case .getUsers(let countOf):
            return "?results=\(countOf)"
        }
    }
}
