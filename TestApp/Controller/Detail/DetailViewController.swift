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
        
        let tapEmailGesture = UITapGestureRecognizer(target: self, action: #selector(handleEmail))
        emailLabel.addGestureRecognizer(tapEmailGesture)
        
        let tapPhoneGesture = UITapGestureRecognizer(target: self, action: #selector(handlePhone))
        phoneLabel.addGestureRecognizer(tapPhoneGesture)
        
        let tapLocationGesture = UITapGestureRecognizer(target: self, action: #selector(handleLocation))
        locationLabel.addGestureRecognizer(tapLocationGesture)
        
        updateUI()
    }

    func updateUI() {
        nameLabel.text = "\(passedUser.firstName?.capitalized ?? "") \(passedUser.lastName?.capitalized ?? "")"
        emailLabel.text = passedUser.email ?? ""
        phoneLabel.text = passedUser.phone ?? ""
        locationLabel.text = "\(passedUser.city?.capitalized ?? ""), \(passedUser.state?.capitalized ?? "")"
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
    
    @objc func handleEmail() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Send email to \(passedUser.firstName?.capitalized ?? "this user")", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            let emailAddress = self.passedUser.email ?? ""
            if let url = URL(string: "mailto:\(emailAddress)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func handlePhone() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let phoneNumber = self.passedUser.phone ?? ""
        actionSheet.addAction(UIAlertAction(title: "Text \(passedUser.firstName?.capitalized ?? "this user")", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if let url = URL(string: "sms:\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Call \(passedUser.firstName?.capitalized ?? "this user")", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if let url = URL(string: "tel:\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func handleLocation() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "See \(passedUser.firstName?.capitalized ?? "this user")'s location in maps", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            let location = "\(self.passedUser.state?.capitalized ?? "")"
            var string = ""
            if let stringEncoded = location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                string = "https://maps.google.com/?q=\(stringEncoded)"
            }
            if let url = URL(string: string) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

}
