//
//  UIView+InterfaceBuilder.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 11/09/2019.
//  Copyright © 2019 Matt Quiros. All rights reserved.
//

import UIKit

extension UIView {
	
	/// Returns the root `UIView` in a same-name XIB file where this class is the file's owner.
	/// Note that XIB files can have more than one root `UIView`s, and this function assumes
	/// that there is only one.
	func viewFromOwnedNib(named nibName: String? = nil) -> UIView {
		let bundle = Bundle(for: self.classForCoder)
		return {
			if let nibName = nibName {
				return bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as! UIView
			}
			return bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!.first as! UIView
			}()
	}
	
	/// Returns an instance of this `UIView` subclass containing the view hierarchy defined in
	/// an XIB file of the same name as this class.
	class func instantiateFromNib() -> Self {
		return instantiateFromNibInBundle(Bundle.main)
	}
	
	/// Returns a nib file of the same name as this class.
	class func nib() -> UINib {
		return UINib(nibName: String(forTypeOf: self), bundle: Bundle.main)
	}
	
	/// Private utility function internally used by `instantiateFromNib()` to get around
	/// the limitation of Swift generics.
	private class func instantiateFromNibInBundle<T: UIView>(_ bundle: Bundle) -> T {
		let objects = bundle.loadNibNamed(String(forTypeOf: self), owner: self, options: nil)!
		let view = objects.last as! T
		return view
	}
	
}
