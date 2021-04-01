//
//  LabelButton.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 16/02/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import UIKit

@IBDesignable
class LabelButton: Button {
	
	lazy var titleLabel = UILabel(frame: .zero)
	
	var text: String? {
		didSet {
			refreshTitleLabelForTextFieldBehavior()
		}
	}
	
	var placeholderText: String?
	var placeholderTextColor: UIColor?
	var textColor: UIColor?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupStructure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupStructure()
	}
	
	fileprivate func setupStructure() {
//		addSubviewAndFill(titleLabel)
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupStructure()
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return titleLabel.sizeThatFits(size)
	}
	
	func enableTextFieldBehavior(placeholderText: String, placeholderTextColor: UIColor, textColor: UIColor) {
		self.placeholderText = placeholderText
		self.placeholderTextColor = placeholderTextColor
		self.textColor = textColor
		refreshTitleLabelForTextFieldBehavior()
	}
	
	func refreshTitleLabelForTextFieldBehavior() {
		if text == nil {
			titleLabel.text = placeholderText
			titleLabel.textColor = placeholderTextColor ?? tintColor
		} else {
			titleLabel.text = text
			titleLabel.textColor = textColor ?? tintColor
		}
	}
	
}
