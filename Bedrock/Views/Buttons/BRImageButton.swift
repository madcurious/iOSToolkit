//
//  BRImageButton.swift
//  Bedrock
//
//  Created by Matt Quiros on 16/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

class BRImageButton: BRButton {
	
	private let imageView = UIImageView(frame: CGRect.zero)
	
	var image: UIImage? {
		get {
			return self.imageView.image
		}
		set {
			self.imageView.image = newValue
		}
	}
	
	override var tintColor: UIColor! {
		get {
			return self.imageView.tintColor
		}
		set {
			self.imageView.tintColor = newValue
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubviewsAndFill(self.imageView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.addSubviewsAndFill(self.imageView)
	}
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	convenience init(frame: CGRect, image: UIImage) {
		self.init(frame: frame)
		self.imageView.image = image
	}
	
}
