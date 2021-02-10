//
//  Double.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 5/29/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import Foundation

extension Double {
	
	func isWholeNumber() -> Bool {
		if Double(Int(self)) == self {
			return true
		}
		return false
	}
	
}
