//
//  UIButton.swift
//  Mold
//
//  Created by Matt Quiros on 28/07/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func setAttributedTitle(string: String, font: UIFont, textColor: UIColor) {
        self.setAttributedTitle(NSAttributedString(string: string, font: font, textColor: textColor), forState: .Normal)
        self.setAttributedTitle(NSAttributedString(string: string, font: font, textColor: textColor.colorWithAlphaComponent(0.2)), forState: .Highlighted)
    }
    
}
