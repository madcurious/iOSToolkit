//
//  NSCharacterSet.swift
//  Mold
//
//  Created by Matt Quiros on 4/18/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSCharacterSet {
    
    /**
     The numbers 0 to 9 and the period.
     */
    public class func decimalNumberCharacterSet() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "0123456789.")
    }
    
    /**
     The numbers 0 to 9.
     */
    public class func wholeNumberCharacterSet() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "0123456789")
    }
    
}