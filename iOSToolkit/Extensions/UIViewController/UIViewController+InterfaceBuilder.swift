//
//  UIViewController+InterfaceBuilder.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matthew Quiros. All rights reserved.
//

import UIKit

extension UIViewController {
	
	/// Returns the `UIView` for which this controller is the file's owner.
	func viewFromOwnedNib(named nibName: String? = nil) -> UIView {
		let bundle = Bundle(for: self.classForCoder)
		return {
			if let nibName = nibName {
				return bundle.loadNibNamed(nibName, owner: self, options: nil)!.last as! UIView
			}
			return bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)!.last as! UIView
			}()
	}
	
}
