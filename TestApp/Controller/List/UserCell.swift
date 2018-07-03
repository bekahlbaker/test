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
        floatingBackgroundView.backgroundColor = UIColor.white
    }
    
    func configureCell(with user: User) {
        cellShrink()

        guard let firstName = user.firstName,
            let lastName = user.lastName  else { return }
        
        nameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
        
        guard let profileUrl = user.imageMed else { return }
        
        APIClient.downloadImage(with: profileUrl ) { (response) in
            if response != nil {
                self.profileImageView.image = response!
            } else {
                print("ERROR MAKING REQUEST FOR Image")
            }
        }
        // Could cache images with NSCache or Kingfisher if there was more data being fetched
        
        switch isSelected {
        case true: cellGrow()
        case false: cellShrink()
        }
    }
    
    func cellGrow() {
        UIView.animate(withDuration: 0.5, animations: {
            self.floatingBackgroundView.layer.cornerRadius = 10
            self.floatingBackgroundView.layer.shadowOpacity = 0.3
            self.floatingBackgroundView.layer.shadowRadius = 3.5
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor(red:0.13, green:0.47, blue:0.81, alpha:1.0).cgColor
                
            let originalNameTransform = self.nameLabel.transform
            let originalImageTransform = self.profileImageView.transform
            let originalButtonTransform = self.highlightButton.transform
            
            let scaledNameTransform = originalNameTransform.scaledBy(x: 1.25, y: 1.25)
            let scaledImageTransform = originalImageTransform.scaledBy(x: 1.25, y: 1.25)
            let scaledButtonTransform = originalButtonTransform.scaledBy(x: 1.25, y: 1.25)
            
            let scaledAndTranslatedNameTransform = scaledNameTransform.translatedBy(x: 24, y: 0)
            let scaledAndTranslatedImageTransform = scaledImageTransform.translatedBy(x: 4, y: 0)
            let scaledAndTranslatedButtonTransform = scaledButtonTransform.translatedBy(x: -4, y: 0)
            
            UIView.animate(withDuration: 0.8, animations: {
                self.nameLabel.transform = scaledAndTranslatedNameTransform
                self.profileImageView.transform = scaledAndTranslatedImageTransform
                self.highlightButton.transform = scaledAndTranslatedButtonTransform
            })

        })
    }
    
    func cellShrink() {
        UIView.animate(withDuration: 0.5, animations: {
            self.floatingBackgroundView.layer.cornerRadius = 3
            self.floatingBackgroundView.layer.shadowOpacity = 0
            self.floatingBackgroundView.layer.shadowRadius = 0
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor.clear.cgColor
            
                UIView.animate(withDuration: 0.8, animations: {
                    self.profileImageView.transform = CGAffineTransform.identity
                    self.nameLabel.transform = CGAffineTransform.identity
                    self.highlightButton.transform = CGAffineTransform.identity
                })
        })
    }
    // TODO: shrink is not always animated
}
