//
//  BRDateUtilsTest.swift
//  iOSToolkitTests
//
//  Created by Matthew Quiros on 03/10/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import XCTest

class BRDateUtilsTest: XCTestCase {
    
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
    
    func assertEqual(components: DateComponents, day: Int, month: Int, year: Int, hour: Int, minute: Int, second: Int) {
        XCTAssertEqual(components.day, day)
        XCTAssertEqual(components.month, month)
        XCTAssertEqual(components.year, year)
        XCTAssertEqual(components.hour, hour)
        XCTAssertEqual(components.minute, minute)
        XCTAssertEqual(components.second, second)
    }
    
}
