//
//  NSCharacterSet.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 4/18/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSCharacterSet {
    
    public class func decimalNumberCharacterSet() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "0123456789.")
    }
    
    public class func wholeNumberCharacterSet() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "0123456789")
    }
    
}