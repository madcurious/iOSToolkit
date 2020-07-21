//
//  UIViewController+Embedding.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 4/20/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func embedChild(_ childViewController: UIViewController, in superview: UIView, fillTo layoutGuide: UIView.LayoutGuide) {
		self.addChild(childViewController)
		superview.addSubviewAndFill(childViewController.view, relativeTo: layoutGuide)
		childViewController.didMove(toParent: self)
	}
	
	func unembedChild(_ childViewController: UIViewController) {
		childViewController.unembedFromParent()
	}
	
	func unembedFromParent() {
		self.willMove(toParent: nil)
		self.view.removeFromSuperview()
		self.removeFromParent()
	}
	
}
