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
    
    public var text: String? {
        didSet {
            refreshTitleLabelForTextFieldBehavior()
        }
    }
    
    var placeholderText = "Select"
    var placeholderTextColor = UIColor.hex(0xcccccc)
    var textColor = UIColor.black
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let internalView = self.viewFromOwnedNib()
        internalView.isUserInteractionEnabled = false
        internalView.clearAllBackgroundColors()
        addSubviewsAndFill(internalView)
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return titleLabel.sizeThatFits(size)
    }
    
    public func enableTextFieldBehavior(placeholderText: String, placeholderTextColor: UIColor, textColor: UIColor) {
        self.placeholderText = placeholderText
        self.placeholderTextColor = placeholderTextColor
        self.textColor = textColor
        refreshTitleLabelForTextFieldBehavior()
    }
    
    func refreshTitleLabelForTextFieldBehavior() {
        if text == nil {
            titleLabel.text = placeholderText
            titleLabel.textColor = placeholderTextColor
        } else {
            titleLabel.text = text
            titleLabel.textColor = textColor
        }
    }
    
}
