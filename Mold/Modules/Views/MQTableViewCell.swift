//
//  MQTableViewCell.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/4/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

/**
A subclass of `UITableViewCell` that preserves its subviews' background colors
even when the cell is selected of highlighted. Set the background colors in
`applyConstantColors()`, which is invoked upon cell selection or highlight.
*/
public class MQTableViewCell: UITableViewCell {
    
    public func applyConstantColors() {
        
    }
    
    public override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.applyConstantColors()
    }
    
    public override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.applyConstantColors()
    }
    
}
