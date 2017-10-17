//
//  CharacterSet.swift
//  Mold
//
//  Created by Matt Quiros on 4/18/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension CharacterSet {
    
    /**
     The numbers 0 to 9 and the period.
     */
    public static func decimalNumberCharacterSet() -> CharacterSet {
        return CharacterSet(charactersIn: "0123456789.")
    }
    
    /**
     The numbers 0 to 9.
     */
    public static func wholeNumberCharacterSet() -> CharacterSet {
        return CharacterSet(charactersIn: "0123456789")
    }
    
}
