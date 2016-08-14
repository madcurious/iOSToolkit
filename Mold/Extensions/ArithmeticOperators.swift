//
//  ArithmeticOperators.swift
//  Mold
//
//  Created by Matt Quiros on 14/08/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberBySubtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByMultiplyingBy(rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByDividingBy(rhs)
}

public func +=(inout lhs: NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs + rhs
}

public func -=(inout lhs: NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs - rhs
}

public func *=(inout lhs: NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs * rhs
}

public func /=(inout lhs: NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs / rhs
}