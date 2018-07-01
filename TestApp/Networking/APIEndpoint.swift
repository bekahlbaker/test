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
    var fullURL: String {
        return baseURL + path
    }
}
