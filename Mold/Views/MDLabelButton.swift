//
//  MDLabelButton.swift
//  Mold
//
//  Created by Matt Quiros on 16/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public class MDLabelButton: MDButton {
    
    public let titleLabel = UILabel(frame: CGRect.zero)
    
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
        self.addSubview(self.titleLabel)
        
        self.top = NSLayoutConstraint(item: self.titleLabel,
                                      attribute: .top,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .top,
                                      multiplier: 1,
                                      constant: 0)
        
        self.trailing = NSLayoutConstraint(item: self.titleLabel,
                                           attribute: .trailing,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .trailing,
                                           multiplier: 1,
                                           constant: 0)
        
        self.bottom = NSLayoutConstraint(item: self.titleLabel,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .bottom,
                                           multiplier: 1,
                                           constant: 0)
        
        self.leading = NSLayoutConstraint(item: self.titleLabel,
                                           attribute: .leading,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .leading,
                                           multiplier: 1,
                                           constant: 0)
        
        self.addConstraints([self.top, self.trailing, self.bottom, self.leading])
    }
    
}
