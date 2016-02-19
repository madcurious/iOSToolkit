//
//  MQLoadingOverlay.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/19/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public class MQLoadingOverlay : UIView {
    
    var translucentView: UIView
    var activityIndicator: UIActivityIndicatorView
    
    public init() {
        self.translucentView = UIView()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        super.init(frame: CGRectZero)
        
        self.setupViews()
        self.addAutolayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clearColor()
        
        self.translucentView.backgroundColor = UIColor.blackColor()
        self.translucentView.alpha = 0.7
        self.translucentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubviewAndFill(self.translucentView)
        
        self.activityIndicator.startAnimating()
        self.addSubview(self.activityIndicator)
    }
    
    func addAutolayout() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Center the activity indicator.
        self.addConstraints([
            NSLayoutConstraint(item: self.activityIndicator,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.activityIndicator,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: self,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0)
            ])
    }
    
}