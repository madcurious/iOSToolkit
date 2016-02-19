//
//  MQFieldTextFieldCell.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 20/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

/**
 A `UITableViewCell` with a label on the left and a `UITextField` on the right, for modifying
 the value of an `MQField`.
 */
public class MQFieldTextFieldCell: MQFieldCell {
    
    public var wrapperView: UIView
    public var nameLabel: UILabel
    public var textField: MQFieldTextField
    
    public override var field: MQField? {
        didSet {
            defer {
                self.setNeedsLayout()
            }
            guard let field = self.field else {
                self.nameLabel.text = nil
                self.textField.field = nil
                return
            }
            self.nameLabel.text = field.label
            self.textField.field = field
        }
    }
    
    public override var delegate: AnyObject? {
        didSet {
            guard let delegate = self.delegate as? MQFieldTextFieldDelegate
                else {
                    return
            }
            self.textField.delegate = delegate
        }
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.wrapperView = UIView()
        self.nameLabel = UILabel()
        self.textField = MQFieldTextField()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupSubviews()
        self.addAutolayout()
        
        self.selectionStyle = .None
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Unimplemented")
    }
    
    func setupSubviews() {
        self.wrapperView.backgroundColor = UIColor.clearColor()
        
        self.textField.borderStyle = .None
        self.textField.textAlignment = .Right
        self.textField.clearButtonMode = .WhileEditing
        
        UIView.disableAutoresizingMasksInViews(self.wrapperView, self.nameLabel, self.textField)
        self.wrapperView.addSubviews(self.nameLabel, self.textField)
        self.contentView.addSubviewAndFill(self.wrapperView)
    }
    
    func addAutolayout() {
        let rules = ["H:|-10-[nameLabel]-10-[textField]-10-|",
            "V:|-0-[nameLabel]-0-|",
            "V:|-0-[textField]-0-|"]
        let views = ["nameLabel" : self.nameLabel,
            "textField" : self.textField]
        self.wrapperView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormatArray(rules,
            metrics: nil,
            views: views))
        
        self.nameLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
    }
    
}
