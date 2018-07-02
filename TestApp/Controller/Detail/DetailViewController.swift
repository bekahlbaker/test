//
//  DetailViewController.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/2/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var passedUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let firstName = passedUser.firstName,
            let lastName = passedUser.lastName {
            nameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
        }

    }

}
