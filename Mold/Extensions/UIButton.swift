//
//  UIButton.swift
//  Mold
//
//  Created by Matt Quiros on 04/07/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIButton {
    
    public func setAttributedTitle(string: NSAttributedString?, forStates states: UIControlState ...) {
        for state in states {
            self.setAttributedTitle(string, forState: state)
        }
    }
    
}

