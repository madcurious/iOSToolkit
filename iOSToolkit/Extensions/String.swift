//
//  String.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 4/18/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import Foundation

extension String {
	
	/// Returns a string describing the type of an object.
	init(forTypeOf object: Any) {
		self.init(describing: type(of: object))
	}
	
	/// Returns the string without the surrounding whitespace.
  func trim() -> String  {
    return trimmingCharacters(in: CharacterSet.whitespaces)
  }
  
}
