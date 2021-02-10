//
//  NSAttributedString.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 28/07/2016.
//  Copyright © 2016 Matthew Quiros. All rights reserved.
//

import UIKit

extension NSAttributedString {
	
	convenience init(string: String, font: UIFont, textColor: UIColor) {
		self.init(string: string, attributes: [
		NSAttributedString.Key.font : font,
		NSAttributedString.Key.foregroundColor : textColor
		])
	}
	
	convenience init(attributedStrings: NSAttributedString ...) {
		let finalString = NSMutableAttributedString()
		for string in attributedStrings {
			finalString.append(string)
		}
		self.init(attributedString: finalString)
	}
	
}
