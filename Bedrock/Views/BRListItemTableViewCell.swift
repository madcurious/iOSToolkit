//
//  BRListItemTableViewCell.swift
//  iOSCodingTask_MattQuiros
//
//  Created by Matt Quiros on 17/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

class BRListItemTableViewCell: UITableViewCell {
    
    let listItemView = BRListItemView(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        listItemView.isUserInteractionEnabled = false
        contentView.addSubviewsAndFill(listItemView)
    }
    
}
