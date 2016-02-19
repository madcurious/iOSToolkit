//
//  UIViewController.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/20/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

private let kLoadingOverlay = MQLoadingOverlay()

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
    
}
