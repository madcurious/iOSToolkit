//
//  MDLoadingOverlay.swift
//  Mold
//
//  Created by Matt Quiros on 4/19/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

open class MDLoadingOverlay : UIView {
    
    var translucentView: UIView
    var activityIndicator: UIActivityIndicatorView
    
    public init() {
        self.translucentView = UIView()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        super.init(frame: CGRect.zero)
        
        self.setupViews()
        self.addAutolayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
        
        self.translucentView.backgroundColor = UIColor.black
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
                attribute: .centerX,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerX,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: self.activityIndicator,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: 1,
                constant: 0)
            ])
    }
    
}
