//
//  UIButton.swift
//  Mold
//
//  Created by Matt Quiros on 28/07/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func setAttributedTitle(_ string: String, font: UIFont, textColor: UIColor) {
        self.setAttributedTitle(NSAttributedString(string: string, font: font, textColor: textColor), for: UIControlState())
        self.setAttributedTitle(NSAttributedString(string: string, font: font, textColor: textColor.withAlphaComponent(0.2)), for: .highlighted)
    }
    
}
