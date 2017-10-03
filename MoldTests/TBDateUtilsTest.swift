//
//  TBDateUtilsTest.swift
//  MoldTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest

class TBDateUtilsTest: XCTestCase {
    
    func makeDate(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return Calendar.current.date(from: components)!
    }
    
    func significantComponents(from date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
    }
    
}
