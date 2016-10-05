//
//  NSAttributedString.swift
//  Mold
//
//  Created by Matt Quiros on 28/07/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    public convenience init(string: String, font: UIFont, textColor: UIColor) {
        self.init(string: string, attributes: [
            NSFontAttributeName : font,
            NSForegroundColorAttributeName : textColor
            ])
    }
    
    public convenience init(attributedStrings: NSAttributedString ...) {
        let finalString = NSMutableAttributedString()
        for string in attributedStrings {
            finalString.append(string)
        }
        self.init(attributedString: finalString)
    }
    
}
