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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var passedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapEmailGesture = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        emailLabel.addGestureRecognizer(tapEmailGesture)
        
        updateUI()
    }

    func updateUI() {
        nameLabel.text = "\(passedUser.firstName ?? "John".capitalized) \(passedUser.lastName ?? "Doe".capitalized)"
        emailLabel.text = passedUser.email ?? "john@example.com"
        phoneLabel.text = passedUser.phone ?? "555-555-5555"
        locationLabel.text = "\(passedUser.city ?? "Dallas"), \(passedUser.state ?? "Texas")"
        genderLabel.text = passedUser.gender ?? ""
        ageLabel.text = "\(passedUser.age ?? 0)"
        
        guard let profileUrl = passedUser.imageLarge else { return }
        APIClient.downloadImage(with: profileUrl ) { (response) in
            if response != nil {
                self.profileImageView.image = response!
            } else {
                print("ERROR MAKING REQUEST FOR Image")
            }
        }
    }
    
    @objc func sendEmail() {
        
    }

}
