//
//  MQField.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/18/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public class MQField {
    
    /**
    The name of this field.
    */
    public var name: String
    
    /**
    The label to use when the field is displayed, which may be different
    than the name. For example, a field named *Weight* might be displayed
    with a label *Weight (lbs.)*.
    */
    public var label: String
    
    /**
    The value of this field.
    */
    public var value: Any?
    
    public var keyboardType: UIKeyboardType
    public var autocapitalizationType: UITextAutocapitalizationType
    public var validCharacterSet: NSCharacterSet?
    public var secureTextEntry: Bool
    
    public var invalidCharacterSet: NSCharacterSet? {
        get {
            if let validCharacterSet = self.validCharacterSet {
                return validCharacterSet.invertedSet
            }
            return nil
        }
    }
    
    public init(name: String, label: String? = nil, value: Any? = nil,
        keyboardType: UIKeyboardType = .Default,
        autocapitalizationType: UITextAutocapitalizationType = .Words,
        validCharacterSet: NSCharacterSet? = nil,
        secureTextEntry: Bool = false) {
            self.name = name
            self.label = label ?? name
            self.value = value
            
            self.keyboardType = keyboardType
            self.autocapitalizationType = autocapitalizationType
            self.validCharacterSet = validCharacterSet
            self.secureTextEntry = secureTextEntry
    }
    
}