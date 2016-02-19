//
//  MQLoadingView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/19/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MQLoadingView: UIView {

    public var spinnerView: UIActivityIndicatorView
    public var loadingLabel: UILabel
    public var containerView: UIView
    
    public var text: String? {
        didSet {
            if let text = self.text {
                self.loadingLabel.text = text
            } else {
                self.loadingLabel.text = ""
            }
            self.setNeedsLayout()
        }
    }
    
    public init() {
        self.spinnerView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        
        self.loadingLabel = UILabel()
        self.loadingLabel.text = "Loading"
        self.loadingLabel.numberOfLines = 0
        self.loadingLabel.lineBreakMode = .ByWordWrapping
        self.loadingLabel.textAlignment = .Center
        
        self.containerView = UIView()
        self.containerView.backgroundColor = UIColor.clearColor()
        
        super.init(frame: CGRectZero)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.containerView.addSubviews(self.spinnerView, self.loadingLabel)
        self.addSubviews(self.containerView)
        self.addAutolayout()
        
        self.spinnerView.startAnimating()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAutolayout() {
        UIView.disableAutoresizingMasksInViews(
            self.spinnerView,
            self.loadingLabel,
            self.containerView)
        
        self.addAutolayoutInContainerView()
        self.addAutolayoutInMainView()
    }
    
    func addAutolayoutInContainerView() {
        let views = ["loadingLabel" : self.loadingLabel,
            "spinnerView" : self.spinnerView,
            "containerView" : self.containerView]
        
        let rules = ["H:|-0-[loadingLabel]-0-|",
            "V:|-0-[spinnerView]-0-[loadingLabel]-0-|"]
        
        self.containerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormatArray(rules, metrics: nil, views: views))
        
        // Center the spinner view horizontally.
        
        self.containerView.addConstraint(
            NSLayoutConstraint(item: self.spinnerView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self.containerView,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0))
    }
    
    func addAutolayoutInMainView() {
        self.addConstraints([
            NSLayoutConstraint(item: self.containerView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.containerView,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.containerView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Width,
                multiplier: 2.0 / 3,
                constant: 0)
            ])
    }

}
