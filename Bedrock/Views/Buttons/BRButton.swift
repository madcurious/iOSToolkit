//
//  BRButton.swift
//  Mold
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

open class BRButton: UIControl {
    
    open override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, animations: {[unowned self] in
                self.alpha = self.isHighlighted ? 0.1 : 1.0
            }) 
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        disableUserInteractionInSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        disableUserInteractionInSubviews()
    }
    
    internal func disableUserInteractionInSubviews() {
        subviews.forEach {
            $0.isUserInteractionEnabled = false
        }
    }
    
    open override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        subview.isUserInteractionEnabled = false
    }
    
}
