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
    
    public func embedChildViewController(_ childViewController: UIViewController) {
        self.embedChildViewController(childViewController, fillSuperview: true)
    }
    
    public func embedChildViewController(_ childViewController: UIViewController, fillSuperview: Bool) {
        self.embedChildViewController(childViewController, toView: self.view, fillSuperview: fillSuperview)
    }
    
    public func embedChildViewController(_ childViewController: UIViewController, toView superview: UIView, fillSuperview: Bool = true) {
        self.addChildViewController(childViewController)
        
        if fillSuperview {
            superview.addSubviewAndFill(childViewController.view)
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
    
    public func showLoadingOverlay(_ show: Bool) {
        if let appDelegate = UIApplication.shared.delegate,
            let someWindow = appDelegate.window,
            let window = someWindow {
                if show {
                    window.addSubviewAndFill(kLoadingOverlay)
                } else {
                    kLoadingOverlay.removeFromSuperview()
                }
        }
    }
    
    public func setCustomTransitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.transitioningDelegate = transitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
}

// MARK: - Modals
extension UIViewController {
    
    public func addCancelAndDoneBarButtonItems(_ cancelButtonTitle: String? = "Cancel", doneButtonTitle: String? = "Done") {
        self.addCancelBarButtonItem(cancelButtonTitle)
        self.addDoneBarButtonItem(doneButtonTitle)
    }
    
    public func addCancelBarButtonItem(_ cancelButtonTitle: String? = "Cancel") {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(handleTapOnCancelBarButtonItem(_:)))
    }
    
    public func addDoneBarButtonItem(_ doneButtonTitle: String? = "Done") {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: doneButtonTitle, style: .plain, target: self, action: #selector(handleTapOnDoneBarButtonItem(_:)))
    }
    
    open func handleTapOnCancelBarButtonItem(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    open func handleTapOnDoneBarButtonItem(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Forms
extension UIViewController {
    
    open var formScrollView: UIScrollView {
        fatalError("Unimplemented \(#function): You must provide the scroll view for the form.")
    }
    
    public func addTapGestureRecognizerToDismissKeyboard() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    public func addFormScrollViewKeyboardObservers() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    public func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        
        var bottomInset = keyboardFrame.height
        
        // If the view controller is in a tab bar controller, take into account the tab bar height.
        if let tabBar = self.tabBarController?.tabBar {
            bottomInset -= tabBar.bounds.size.height
        }
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        self.formScrollView.contentInset = insets
        self.formScrollView.scrollIndicatorInsets = insets
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let insets = UIEdgeInsets.zero
        self.formScrollView.contentInset = insets
        self.formScrollView.scrollIndicatorInsets = insets
    }
    
}
