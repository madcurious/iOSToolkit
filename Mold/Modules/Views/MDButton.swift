//
//  MDButton.swift
//  Mold
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MDButton: UIControl {
    
    public override var highlighted: Bool {
        didSet {
            UIView.animateWithDuration(0.2) {[unowned self] in
                self.alpha = self.highlighted ? 0.1 : 1.0
            }
        }
    }
    
}