//
//  UIAlertController.swift
//  Bedrock
//
//  Created by Matt Quiros on 04/07/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

extension UIAlertController {
	
	/// Adds a default cancel action to an alert controller.
	func addCancelAction() {
		let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {[unowned self] _ in
			self.dismiss(animated: true, completion: nil)
		})
		addAction(action)
	}
	
}
