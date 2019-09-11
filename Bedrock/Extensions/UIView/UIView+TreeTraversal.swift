//
//  UIView+TreeTraversal.swift
//  Bedrock
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import UIKit

extension UIView {
	
	class func clearBackgroundColors(_ views: UIView...) {
		for view in views {
			view.backgroundColor = UIColor.clear
		}
	}
	
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
	
	/// Performs the `block` on the entire view hierarchy, starting from the receiver
	/// as the root of the tree.
	func performRecursively(_ block: (UIView) -> ()) {
		UIView.performRecursively(from: self, block: block)
	}
	
}
