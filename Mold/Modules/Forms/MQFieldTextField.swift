//
//  MQFieldTextField.swift
//  CheersOAPE
//
//  Created by Matt Quiros on 4/18/15.
//  Copyright (c) 2015 Silicon Valley Insight. All rights reserved.
//

import UIKit

public class MQFieldTextField : UITextField {
    
    public weak var field: MQField? {
        didSet {
            if let field = self.field {
                self.applyTextInputTraits()
                if let value = field.value as? String {
                    self.text = value
                    return
                }
            }
            self.text = nil
        }
    }
    
    public init() {
        super.init(frame: CGRectZero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clearButtonMode = .WhileEditing
        self.keyboardType = .Default
    }
    
    func applyTextInputTraits() {
        if let field = self.field {
            self.keyboardType = field.keyboardType
            self.autocapitalizationType = field.autocapitalizationType
            self.secureTextEntry = field.secureTextEntry
        }
    }
    
}