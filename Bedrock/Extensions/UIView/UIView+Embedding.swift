//
//  UIView+Embedding.swift
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
