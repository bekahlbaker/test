//
//  UserCell.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/2/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import UIKit

protocol HighlightButtonDelegate {
    func cellIndexTapped(at index: IndexPath)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var floatingBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var highlightButton: UIButton!
    @IBAction func hightlightButtonTapped(_ sender: Any) {
        self.delegate.cellIndexTapped(at: indexPath)
    }
    
    var delegate: HighlightButtonDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        floatingBackgroundView.layer.cornerRadius = 3
        highlightButton.layer.cornerRadius = 5
    }
    
    func configureCell(with user: User) {
        self.floatingBackgroundView.backgroundColor = UIColor.white
        guard let firstName = user.firstName,
            let lastName = user.lastName  else { return }
        
        nameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
        
        guard let profileUrl = user.imageMed else { return }
        
        APIClient.downloadImage(with: profileUrl ) { (response) in
            if response != nil {
                self.profileImageView.image = response!
            } else {
                print("error making request for Image")
            }
        }
        // Could cache images with NSCache or Kingfisher if there was more data being fetched
        
        switch isSelected {
        case true: cellGrow()
        case false: cellShrink()
        }
    }
    
    func cellGrow() {
        UIView.animate(withDuration: 0.4, animations: {
            self.floatingBackgroundView.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
            self.floatingBackgroundView.layer.cornerRadius = 10
            self.floatingBackgroundView.layer.shadowOpacity = 0.3
            self.floatingBackgroundView.layer.shadowRadius = 3.5
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        })
    }
    
    func cellShrink() {
        UIView.animate(withDuration: 0.4, animations: {
            self.floatingBackgroundView.backgroundColor = UIColor.white
            self.floatingBackgroundView.layer.cornerRadius = 3
            self.floatingBackgroundView.layer.shadowOpacity = 0
            self.floatingBackgroundView.layer.shadowRadius = 0
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor.clear.cgColor
        })
    }
}
