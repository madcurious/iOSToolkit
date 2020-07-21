//
//  Debug.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import Foundation

class Debug {
	
	class func stringForType(of object: AnyObject) -> String {
		return String(describing: type(of: object))
	}
	
	class func printJsonObject(_ object: Decodable) throws {
		let data: Data = try {
			if let data = object as? Data {
				return data
			} else {
				return try JSONSerialization.data(withJSONObject: object, options: [])
			}
			}()
		let string = String(data: data, encoding: .utf8)!
		print(string)
	}
	
}
