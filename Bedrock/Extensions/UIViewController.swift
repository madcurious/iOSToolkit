//
//  UIViewController.swift
//  Bedrock
//
//  Created by Matt Quiros on 4/20/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func embedChildViewController(_ childViewController: UIViewController, toView superview: UIView, fillSuperview: Bool) {
		if fillSuperview {
			self.embedChildViewController(childViewController, toView: superview) {
				childViewController.view.fillSuperview()
			}
		} else {
			self.embedChildViewController(childViewController, toView: superview, completionBlock: nil)
		}
	}
	
	func embedChildViewController(_ childViewController: UIViewController, toView superview: UIView, completionBlock: (() -> ())?) {
		self.addChildViewController(childViewController)
		superview.addSubview(childViewController.view)
		childViewController.didMove(toParentViewController: self)
		completionBlock?()
	}
	
	func unembedChildViewController(_ childViewController: UIViewController) {
		childViewController.unembedFromParentViewController()
	}
	
	func unembedFromParentViewController() {
		self.willMove(toParentViewController: nil)
		self.view.removeFromSuperview()
		self.removeFromParentViewController()
	}
	
	func setCustomTransitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate) {
		self.transitioningDelegate = transitioningDelegate
		self.modalPresentationStyle = .custom
	}
	
	func viewFromOwnedNib(named nibName: String? = nil) -> UIView {
		let bundle = Bundle(for: self.classForCoder)
		return {
			if let nibName = nibName {
				return bundle.loadNibNamed(nibName, owner: self, options: nil)!.last as! UIView
			}
			return bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!.last as! UIView
			}()
	}
	
}
