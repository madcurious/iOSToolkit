//
//  MQFieldSelectionCell.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 20/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public class MQFieldSelectionCell: MQFieldCell {
    
    public override var field: MQField? {
        didSet {
            defer {
                self.setNeedsLayout()
            }
            guard let field = self.field
                else {
                    self.textLabel?.text = nil
                    self.detailTextLabel?.text = nil
                    return
            }
            self.textLabel?.text = field.label
            self.detailTextLabel?.text = field.value as? String
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value2, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .DisclosureIndicator
        self.textLabel?.textAlignment = .Left
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .ByWordWrapping
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

