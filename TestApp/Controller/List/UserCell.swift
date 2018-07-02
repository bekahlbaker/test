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
    var profileImageX: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        floatingBackgroundView.layer.cornerRadius = 3
        highlightButton.layer.cornerRadius = 5
        floatingBackgroundView.backgroundColor = UIColor.white
    }
    
    func configureCell(with user: User) {
        self.profileImageView.transform = CGAffineTransform.identity
        self.nameLabel.transform = CGAffineTransform.identity
        self.highlightButton.transform = CGAffineTransform.identity
        
        self.nameLabel.center = CGPoint(x: self.nameLabel.center.x, y: self.nameLabel.center.y)
        
        profileImageX = self.profileImageView.center.x
        if let firstName = user.firstName,
            let lastName = user.lastName {
                nameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
        }
        
        switch isSelected {
        case true: cellGrow()
        case false: cellShrink()
        }
    }
    
    func cellGrow() {
        UIView.animate(withDuration: 0.5) {
            self.floatingBackgroundView.layer.cornerRadius = 10
            self.floatingBackgroundView.layer.shadowOpacity = 0.3
            self.floatingBackgroundView.layer.shadowRadius = 3.5
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor(red:0.13, green:0.47, blue:0.81, alpha:1.0).cgColor
            
            self.profileImageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self.highlightButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)

            let originalTransform = self.nameLabel.transform
            let scaledTransform = originalTransform.scaledBy(x: 1.25, y: 1.25)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 24, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                self.nameLabel.transform = scaledAndTranslatedTransform
            })
        }
    }
    
    func cellShrink() {
        UIView.animate(withDuration: 0.5) {
            self.floatingBackgroundView.layer.cornerRadius = 3
            self.floatingBackgroundView.layer.shadowOpacity = 0
            self.floatingBackgroundView.layer.shadowRadius = 0
            self.floatingBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.floatingBackgroundView.layer.shadowColor = UIColor.clear.cgColor
            self.profileImageView.transform = CGAffineTransform.identity
            self.nameLabel.transform = CGAffineTransform.identity
            self.highlightButton.transform = CGAffineTransform.identity
        }
    }
    
    
    // TODO: Cache images / fetch from cache first
}
