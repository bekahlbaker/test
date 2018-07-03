//
//  UnderlinedLabel.swift
//  TestApp
//
//  Created by Rebekah Baker on 7/3/18.
//  Copyright © 2018 Bekah Baker. All rights reserved.
//

import UIKit

class UnderlinedLabel: UILabel {

    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle,
                                        value: NSUnderlineStyle.styleSingle.rawValue,
                                        range: textRange)
            self.attributedText = attributedText
        }
    }

}
