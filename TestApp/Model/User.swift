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
    let imageThumb: String?
    let imageMed: String?
    let imageLarge: String?
    let gender: String?
    let age: Int?
    let phone: String?
    let city: String?
    let state: String?
    
    init?(json: JSON) {
        self.firstName = "name.first" <~~ json
        self.lastName = "name.last" <~~ json
        self.email = "email" <~~ json
        self.imageThumb = "picture.thumbnail" <~~ json
        self.imageMed = "picture.medium" <~~ json
        self.imageLarge = "picture.large" <~~ json
        self.gender = "gender" <~~ json
        self.age = "dob.age" <~~ json
        self.phone = "phone" <~~ json
        self.city = "location.city" <~~ json
        self.state = "location.state" <~~ json
    }
    
    // Using Gloss to handle parsing json to user model
    // Without Gloss set up, initialize user with dictionary values OR Swift's Decodable
}
