//
//  MQDefaultStartingView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/1/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MQDefaultStartingView: MQStartingView {
    
    public var startingTextLabel: UILabel
    
    public override var text: String? {
        didSet {
            if let text = self.text {
                self.startingTextLabel.text = text
                self.setNeedsLayout()
            }
        }
    }
    
    public init() {
        self.startingTextLabel = UILabel()
        self.startingTextLabel.numberOfLines = 0
        self.startingTextLabel.lineBreakMode = .ByWordWrapping
        self.startingTextLabel.text = "Nothing here yet."
        self.startingTextLabel.textAlignment = .Center
        
        super.init(frame: CGRectZero)
        
        self.addSubview(self.startingTextLabel)
        self.backgroundColor = UIColor.whiteColor()
        self.addAutolayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAutolayout() {
        // The startingTextLabel is centered vertically,
        // with a width 2/3 that of its superview.
        self.startingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
            NSLayoutConstraint(item: self.startingTextLabel,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.startingTextLabel,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.startingTextLabel,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Width,
                multiplier: 2.0 / 3.0,
                constant: 0)
            ])
    }
    
}
