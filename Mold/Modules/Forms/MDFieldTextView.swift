//
//  MDFieldTextView.swift
//  Mold
//
//  Created by Matt Quiros on 7/16/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MDFieldTextView: UITextView {
    
    public weak var field: MDField? {
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
