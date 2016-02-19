//
//  MQFieldTextView.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/16/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MQFieldTextView: UITextView {
    
    public weak var field: MQField? {
        didSet {
            if let field = self.field,
                let value = field.value as? String {
                    self.text = value
                    return
            }
            
            self.text = nil
        }
    }
    
}

