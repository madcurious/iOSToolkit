//
//  MQStartupViewController.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/16/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MQStartupViewController : UIViewController {
    
    public var operation: NSOperation?
    
    lazy var operationQueue = NSOperationQueue()
    lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    private var isComingFromViewDidLoad = true
    
//    public init(operation: NSOperation) {
//        self.operation = operation
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    public required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public override func loadView() {
        self.view = UIView()
        self.view.addSubview(self.activityIndicator)
        
        // Add Autolayout rules.
        
        UIView.disableAutoresizingMasksInViews(activityIndicator)
        
        // Center the loadingView.
        self.view.addConstraints([
            NSLayoutConstraint(item: activityIndicator,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0),
            NSLayoutConstraint(item: activityIndicator,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0),
            ])
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if appearing for the first time.
        if self.isComingFromViewDidLoad {
            
            // Execute the operation if it has been assigned in viewDidLoad.
            // We put the logic inside viewWillAppear so that viewDidLoad can be
            // overridden normally.
            if let operation = self.operation {
                self.operationQueue.addOperation(operation)
            }
            
            self.isComingFromViewDidLoad = false
        }
    }
    
}

