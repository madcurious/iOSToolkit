//
//  +.swift
//  Mold
//
//  Created by Matt Quiros on 08/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(rhs)
}