//
//  UIApplication.swift
//  Bedrock
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import UIKit

extension UIApplication {
	
	func rootViewController() -> UIViewController {
		return UIApplication.shared.delegate!.window!!.rootViewController!
	}
	
}
