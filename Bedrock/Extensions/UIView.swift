//
//  UIView.swift
//  Bedrock
//
//  Created by Matt Quiros on 4/15/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

extension UIView {
	
	/// Adds multiple subviews from back to front.
	func addSubviews(_ views: UIView ...) {
		for view in views {
			self.addSubview(view)
		}
	}
	
	func addSubviewsAndFill(_ views: UIView ...) {
		for view in views {
			addSubviewAndFill(view)
		}
	}
	
	@discardableResult
	func addSubviewAndFill(_ subview: UIView) -> [NSLayoutConstraint] {
		addSubview(subview)
		
		subview.translatesAutoresizingMaskIntoConstraints = false
		
		let constraints = [
			subview.topAnchor.constraint(equalTo: topAnchor),
			trailingAnchor.constraint(equalTo: subview.trailingAnchor),
			bottomAnchor.constraint(equalTo: subview.bottomAnchor),
			subview.leadingAnchor.constraint(equalTo: leadingAnchor)
		]
		constraints.forEach {
			$0.priority = UILayoutPriority(999)
			$0.isActive = true
		}
		
		return constraints
	}
	
	func fillSuperview() {
		if let superview = self.superview {
			self.translatesAutoresizingMaskIntoConstraints = false
			let views = ["view" : self]
			let rules = ["H:|-0-[view]-0-|",
									 "V:|-0-[view]-0-|"]
			superview.addConstraints(
				NSLayoutConstraint.constraintsWithVisualFormatArray(rules,
																														metrics: nil,
																														views: views))
		}
	}
	
	func clearAllBackgroundColors() {
		UIView.clearAllBackgroundColors(from: self)
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
	
	/// Performs the `block` on the entire view hierarchy, starting from the receiver
	/// as the root of the tree.
	func performRecursively(_ block: (UIView) -> ()) {
		UIView.performRecursively(from: self, block: block)
	}
	
}

// MARK: - Class functions
extension UIView {
	
	class func instantiateFromNib() -> Self {
		return self.instantiateFromNibInBundle(Bundle.main)
	}
	
	class func clearBackgroundColors(_ views: UIView...) {
		for view in views {
			view.backgroundColor = UIColor.clear
		}
	}
	
	class func clearBackgroundColors(_ views: [UIView]) {
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
	
	class func nib() -> UINib {
		return UINib(nibName: String(forTypeOf: self), bundle: Bundle.main)
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
	
}

// MARK: - Private functions
fileprivate extension UIView {
	
	class func instantiateFromNibInBundle<T: UIView>(_ bundle: Bundle) -> T {
		let objects = bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!
		let view = objects.last as! T
		return view
	}
	
}
