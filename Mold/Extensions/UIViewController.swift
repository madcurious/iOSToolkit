//
//  UIViewController.swift
//  Mold
//
//  Created by Matt Quiros on 4/20/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

private let kLoadingOverlay = MDLoadingOverlay()

public extension UIViewController {
    
    public func embedChildViewController(childViewController: UIViewController) {
        self.embedChildViewController(childViewController, fillSuperview: true)
    }
    
    public func embedChildViewController(childViewController: UIViewController, fillSuperview: Bool) {
        self.embedChildViewController(childViewController, toView: self.view, fillSuperview: fillSuperview)
    }
    
    public func embedChildViewController(childViewController: UIViewController, toView superview: UIView, fillSuperview: Bool) {
        self.addChildViewController(childViewController)
        
        if fillSuperview {
            superview.addSubviewAndFill(childViewController.view)
        } else {
            superview.addSubview(childViewController.view)
        }
        
        childViewController.didMoveToParentViewController(self)
    }
    
    public func embedChildViewController(childViewController: UIViewController, toView superview: UIView, withFormatStrings formatStrings: [String], metrics: [String : CGFloat]?, views: [String : UIView]) {
        self.addChildViewController(childViewController)
        
        superview.addSubview(childViewController.view)
        let constraints = NSLayoutConstraint.constraintsWithVisualFormatArray(formatStrings, metrics: metrics, views: views)
        childViewController.view.addConstraints(constraints)
        
        childViewController.didMoveToParentViewController(self)
    }
    
    public func showLoadingOverlay(show: Bool) {
        if let appDelegate = UIApplication.sharedApplication().delegate,
            let someWindow = appDelegate.window,
            let window = someWindow {
                if show {
                    window.addSubviewAndFill(kLoadingOverlay)
                } else {
                    kLoadingOverlay.removeFromSuperview()
                }
        }
    }
    
    public func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func addCancelAndDoneBarButtonItems(cancelButtonTitle: String? = "Cancel", doneButtonTitle: String? = "Done") {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButtonTitle, style: .Plain, target: self, action: #selector(handleTapOnCancelBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: doneButtonTitle, style: .Plain, target: self, action: #selector(handleTapOnDoneBarButtonItem(_:)))
    }
    
    public func handleTapOnCancelBarButtonItem(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func handleTapOnDoneBarButtonItem(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
