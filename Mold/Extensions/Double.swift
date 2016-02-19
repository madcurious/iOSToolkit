//
//  Double.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/29/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension Double {
    
    public func isWholeNumber() -> Bool {
        if Double(Int(self)) == self {
            return true
        }
        return false
    }
    
}