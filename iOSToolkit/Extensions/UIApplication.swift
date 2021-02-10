//
//  UIApplication.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIApplication {
	
	/// Returns the root view controller in the app.
	func rootViewController() -> UIViewController {
		return UIApplication.shared.delegate!.window!!.rootViewController!
	}
	
}
