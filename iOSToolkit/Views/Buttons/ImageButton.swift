//
//  ImageButton.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 16/02/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import UIKit

class ImageButton: Button {
	
	/// The image view within the button.
	fileprivate(set) lazy var imageView = UIImageView(frame: CGRect.zero)
	
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
		setupStructure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupStructure()
	}
	
	convenience init(frame: CGRect, image: UIImage) {
		self.init(frame: frame)
		self.imageView.image = image
	}
	
	fileprivate func setupStructure() {
		addSubviewAndFill(imageView)
	}
	
}
