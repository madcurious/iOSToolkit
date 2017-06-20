//
//  MDTextFieldButton.swift
//  Mold
//
//  Created by Matt Quiros on 16/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

/**
 An `MDButton` that handles the display of a a placeholder text and an actual value.
 */
public class MDTextFieldButton: MDButton {
    
    public var font: UIFont {
        get {
            return self.textField.font!
        }
        set {
            self.textField.font = newValue
           
            self.placeholderAttributes[NSAttributedStringKey.font] = newValue
            self.updateAttributedPlaceholder()
        }
    }
    
    public var placeholder: String? {
        didSet {
            let placeholderText = self.placeholder ?? ""
            self.attributedPlaceholder = NSMutableAttributedString(string: placeholderText)
            self.updateAttributedPlaceholder()
        }
    }
    
    public var placeholderTextColor: UIColor? {
        didSet {
            let placeholderTextColor = self.placeholderTextColor ?? UIColor.hex(0xeeeeee)
            self.placeholderAttributes[NSAttributedStringKey.foregroundColor] = placeholderTextColor
            self.updateAttributedPlaceholder()
        }
    }
    
    public var text: String? {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }
    
    public var textColor: UIColor? {
        get {
            return self.textField.textColor
        }
        set {
            self.textField.textColor = newValue
        }
    }
    
    public var edgeInsets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(self.top.constant, self.leading.constant, self.bottom.constant, self.trailing.constant)
        }
        set {
            self.top.constant = newValue.top
            self.trailing.constant = newValue.right
            self.bottom.constant = newValue.bottom
            self.leading.constant = newValue.left
            self.setNeedsLayout()
        }
    }
    
    let textField = UITextField(frame: CGRect.zero)
    var attributedPlaceholder = NSMutableAttributedString()
    var placeholderAttributes = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
        NSAttributedStringKey.foregroundColor : UIColor.hex(0xeeeeee)
    ]
    
    var top: NSLayoutConstraint!
    var trailing: NSLayoutConstraint!
    var bottom: NSLayoutConstraint!
    var leading: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.textField.isUserInteractionEnabled = false
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.textField)
        
        self.top = NSLayoutConstraint(item: self.textField,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .top,
                                      multiplier: 1,
                                      constant: 0)
        
        self.trailing = NSLayoutConstraint(item: self.textField,
                                           attribute: .trailing,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .trailing,
                                           multiplier: 1,
                                           constant: 0)
        
        self.bottom = NSLayoutConstraint(item: self.textField,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 0)
        
        self.leading = NSLayoutConstraint(item: self.textField,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .leading,
                                          multiplier: 1,
                                          constant: 0)
        
        self.addConstraints([self.top, self.trailing, self.bottom, self.leading])
    }
    
    func updateAttributedPlaceholder() {
        self.attributedPlaceholder.setAttributes(self.placeholderAttributes, range: self.attributedPlaceholder.string.fullRange)
        self.textField.attributedPlaceholder = self.attributedPlaceholder
    }
    
}
