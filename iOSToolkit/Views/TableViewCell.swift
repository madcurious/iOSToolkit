//
//  TableViewCell.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 5/4/15.
//  Copyright (c) 2015 Matthew Quiros. All rights reserved.
//

import UIKit

/**
A subclass of `UITableViewCell` that preserves its subviews' background colors
even when the cell is selected or highlighted. Set the background colors in
`applyConstantColors()`, which is invoked upon cell selection or highlight.
*/
class TableViewCell: UITableViewCell {
	
	func applyConstantColors() {
		
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.applyConstantColors()
	}
	
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		self.applyConstantColors()
	}
	
}
