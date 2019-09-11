//
//  BRButton.swift
//  Bedrock
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

class BRButton: UIControl {
	
	override var isHighlighted: Bool {
		didSet {
			UIView.animate(withDuration: 0.2, animations: {[unowned self] in
				self.alpha = self.isHighlighted ? 0.1 : 1.0
			})
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		disableUserInteractionInSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		disableUserInteractionInSubviews()
	}
	
	fileprivate func disableUserInteractionInSubviews() {
		subviews.forEach {
			$0.isUserInteractionEnabled = false
		}
	}
	
	override func didAddSubview(_ subview: UIView) {
		super.didAddSubview(subview)
		subview.isUserInteractionEnabled = false
	}
	
}
