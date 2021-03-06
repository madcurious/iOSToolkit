//
//  CharacterSet.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 4/18/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import Foundation

extension CharacterSet {
	
	/// The numbers 0 to 9 and the period.
	static func decimalNumberCharacterSet() -> CharacterSet {
		return CharacterSet(charactersIn: "0123456789.")
	}
	
	/// The numbers 0 to 9.
	static func wholeNumberCharacterSet() -> CharacterSet {
		return CharacterSet(charactersIn: "0123456789")
	}
	
}
