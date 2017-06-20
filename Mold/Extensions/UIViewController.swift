//
//  UIViewController.swift
//  Mold
//
//  Created by Matt Quiros on 4/20/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func embedChildViewController(_ childViewController: UIViewController) {
        self.embedChildViewController(childViewController, fillSuperview: true)
    }
    
    public func embedChildViewController(_ childViewController: UIViewController, fillSuperview: Bool) {
        self.embedChildViewController(childViewController, toView: self.view, fillSuperview: fillSuperview)
    }
    
    public func embedChildViewController(_ childViewController: UIViewController, toView superview: UIView, fillSuperview: Bool = true) {
        self.addChildViewController(childViewController)
        
        if fillSuperview {
            superview.addSubviewsAndFill(childViewController.view)
        } else {
            superview.addSubview(childViewController.view)
        }
        
        childViewController.didMove(toParentViewController: self)
    }
    
    public func embedChildViewController(_ childViewController: UIViewController, toView superview: UIView, withFormatStrings formatStrings: [String], metrics: [String : AnyObject]?, views: [String : UIView]) {
        self.addChildViewController(childViewController)
        
        superview.addSubview(childViewController.view)
        let constraints = NSLayoutConstraint.constraintsWithVisualFormatArray(formatStrings, metrics: metrics, views: views)
        childViewController.view.addConstraints(constraints)
        
        childViewController.didMove(toParentViewController: self)
    }
    
    public func setCustomTransitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.transitioningDelegate = transitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
}
