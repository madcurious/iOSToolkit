//
//  BRLabelButton.swift
//  Bedrock
//
//  Created by Matt Quiros on 16/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

@IBDesignable
open class BRLabelButton: BRButton {
    
    @IBOutlet public weak var titleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let internalView = self.ownedViewFromNib()
        internalView.isUserInteractionEnabled = false
        internalView.clearAllBackgroundColors()
        addSubviewsAndFill(internalView)
        
        titleLabel.addObserver(self, forKeyPath: #keyPath(UILabel.text), options: .new, context: nil)
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return titleLabel.sizeThatFits(size)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == #keyPath(UILabel.text),
            (object as? UILabel) == titleLabel
            else {
                return
        }
        
        titleLabel.sizeToFit()
        sizeToFit()
    }
    
}
