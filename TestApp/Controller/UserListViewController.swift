//
//  UserListViewController.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/1/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient.request(endpoint: UserEndpoints.getUsers(countOf: 1)) { (response) in
            if response != nil {
               print("USERS RESPONSE ", response)
            } else {
                print("ERROR MAKING REQUEST FOR USERS")
            }
        }
        
        // TODO: Setup tableview, populate with user list
        
        // Setup user detail view, send user through
    }
}
