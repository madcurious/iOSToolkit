//
//  CGSize.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 29/05/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import CoreGraphics

extension CGSize {
	
	/// The largest possible width and height.
	static var max: CGSize {
		return CGSize(width: CGFloat.greatestFiniteMagnitude,
									height: CGFloat.greatestFiniteMagnitude)
	}
	
}