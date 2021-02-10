//
//  UIView+Embedding.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 4/15/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import UIKit

// MARK: - Adding subviews
extension UIView {
	
	/// Refers to the default `UILayoutGuide` properties in a `UIView`.
	enum LayoutGuide {
		/// The layout guide for the view's edges.
		case edges
		
		/// The layout guide for the view's layout margins.
		case layoutMargins
		
		/// The layout guide for the view's safe area.
		@available(iOS 11, *)
		case safeArea
	}
	
	/// Adds a subview and binds the subview's edges to the specified layout guide. By default, a subview binds to the edges,
	/// i.e. it occupies the full frame of the superview. To add padding around the subview, set the superview's `layoutMargins`
	/// or `directionalLayoutMargins` and pass `.layoutMargins` as the `layoutGuide` argument.
	/// To bind to the superview's safe area, pass `.safeArea` as the `layoutGuide` argument.
	func addSubviewAndFill(_ subview: UIView, relativeTo layoutGuide: LayoutGuide = .edges) {
		var topAnchor: NSLayoutYAxisAnchor!
		var trailingAnchor: NSLayoutXAxisAnchor!
		var bottomAnchor: NSLayoutYAxisAnchor!
		var leadingAnchor: NSLayoutXAxisAnchor!
		
		switch layoutGuide {
		case .edges:
			topAnchor = self.topAnchor
			trailingAnchor = self.trailingAnchor
			bottomAnchor = self.bottomAnchor
			leadingAnchor = self.leadingAnchor
		case .layoutMargins:
			topAnchor = layoutMarginsGuide.topAnchor
			trailingAnchor = layoutMarginsGuide.trailingAnchor
			bottomAnchor = layoutMarginsGuide.bottomAnchor
			leadingAnchor = layoutMarginsGuide.leadingAnchor
		case .safeArea:
			if #available(iOS 11, *) {
				topAnchor = safeAreaLayoutGuide.topAnchor
				trailingAnchor = safeAreaLayoutGuide.trailingAnchor
				bottomAnchor = safeAreaLayoutGuide.bottomAnchor
				leadingAnchor = safeAreaLayoutGuide.leadingAnchor
			}
		}
		
		addSubview(subview)
		subview.translatesAutoresizingMaskIntoConstraints = false
		subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
		subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
	}
	
}
