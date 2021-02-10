//
//  NSDecimalNumber.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 14/08/2016.
//  Copyright © 2016 Matthew Quiros. All rights reserved.
//

import Foundation

func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.subtracting(rhs)
}

func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.multiplying(by: rhs)
}

func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.dividing(by: rhs)
}

func +=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs + rhs
}

func -=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs - rhs
}

func *=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs * rhs
}

func /=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs / rhs
}

func >(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
}

func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}
