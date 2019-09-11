//
//  UIView.swift
//  Bedrock
//
//  Created by Matt Quiros on 4/15/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

// MARK: - Adding subviews
extension UIView {
	
	/// Adds a subview and binds its edges to this view's `layoutMarginsGuide`. To provide a padding
	/// around the subview's edges, set this view's `layoutMargins` or `directionalEdgeInsets`
	/// before calling this method. The `layoutMarginsGuide` respects the values of those properties.
	func addSubviewAndFill(_ subview: UIView) {
		addSubview(subview)
		subview.translatesAutoresizingMaskIntoConstraints = false
		subview.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
		layoutMarginsGuide.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
		layoutMarginsGuide.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
		subview.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
	}
	
}

// MARK: - Working with Interface Builder
extension UIView {
	
	func viewFromOwnedNib(named nibName: String? = nil) -> UIView {
		let bundle = Bundle(for: self.classForCoder)
		return {
			if let nibName = nibName {
				return bundle.loadNibNamed(nibName, owner: self, options: nil)!.last as! UIView
			}
			return bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!.last as! UIView
			}()
	}
	
	class func instantiateFromNib() -> Self {
		return self.instantiateFromNibInBundle(Bundle.main)
	}
	
	class func nib() -> UINib {
		return UINib(nibName: String(forTypeOf: self), bundle: Bundle.main)
	}
	
	private class func instantiateFromNibInBundle<T: UIView>(_ bundle: Bundle) -> T {
		let objects = bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!
		let view = objects.last as! T
		return view
	}
	
}

// MARK: - Other utility functions
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
