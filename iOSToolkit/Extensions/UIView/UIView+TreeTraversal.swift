//
//  UIView+TreeTraversal.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIView {
	
	/// Sets to `.clear` the `backgroundColor` of all views in the view hierarchy starting from this view.
	class func clearBackgroundColors(_ views: UIView...) {
		for view in views {
			view.backgroundColor = UIColor.clear
		}
	}
	
	/// Sets to `.clear` the `backgroundColor` of all views in the view hierarchy starting from the specified root view.
	class func clearAllBackgroundColors(from view: UIView) {
		if #available(iOS 9.0, *),
			let stackView = view as? UIStackView {
			for arrangedSubview in stackView.arrangedSubviews {
				clearAllBackgroundColors(from: arrangedSubview)
			}
		} else {
			view.backgroundColor = .clear
			for subview in view.subviews {
				clearAllBackgroundColors(from: subview)
			}
		}
	}
	
	func clearAllBackgroundColors() {
		UIView.clearAllBackgroundColors(from: self)
	}
	
	/// Executes `block` for each view in the view hierarchy that starts from a specified root view.
	class func performRecursively(from root: UIView, block: (UIView) -> ()) {
		if #available(iOS 9.0, *),
			let stackView = root as? UIStackView {
			for arrangedSubview in stackView.arrangedSubviews {
				UIView.performRecursively(from: arrangedSubview, block: block)
			}
		} else {
			block(root)
			for subview in root.subviews {
				UIView.performRecursively(from: subview, block: block)
			}
		}
	}
	
	/// Executes `block` for each view in the view hierarchy starting from this view.
	func performRecursively(_ block: (UIView) -> ()) {
		UIView.performRecursively(from: self, block: block)
	}
	
}
