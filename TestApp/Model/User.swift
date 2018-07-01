//
//  User.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import Foundation
import Gloss

struct User: JSONDecodable {
    let firstName: String?
    let lastName: String?
    let email: String?
    let image: String?
    
    init?(json: JSON) {
        self.firstName = "name.first" <~~ json
        self.lastName = "name.last" <~~ json
        self.email = "email" <~~ json
        self.image = "picture.thumbnail" <~~ json
    }
    
    // Using Gloss to handle parsing json to user model
    // Without Gloss set up, initialize user with dictionary values OR Swift's Decodable
}
