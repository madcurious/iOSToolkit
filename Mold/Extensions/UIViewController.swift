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
    
}

// MARK: - Modals
public extension UIViewController {
    
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

// MARK: - Forms
public extension UIViewController {
    
    public var formScrollView: UIScrollView {
        fatalError("Unimplemented \(#function): You must provide the scroll view for the form.")
    }
    
    /**
     Adds common form behaviors to the view controller, such as tapping on external views to hide the keyboard,
     and to adjust scroll view insets when the keyboard shows or hides.
     
     **IMPORTANT:** You must implement `deinit` and deregister the VC from the default `NSNotificationCenter` if you
     use this function.
     */
    public func applyCommonFormBehaviors() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
            else {
                return
        }
        
        var bottomInset = keyboardSize.height
        
        // If the view controller is in a tab bar controller, take into account the tab bar height.
        if let tabBar = self.tabBarController?.tabBar {
            bottomInset -= tabBar.bounds.size.height
        }
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        self.formScrollView.contentInset = insets
        self.formScrollView.scrollIndicatorInsets = insets
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let insets = UIEdgeInsetsZero
        self.formScrollView.contentInset = insets
        self.formScrollView.scrollIndicatorInsets = insets
    }
    
}