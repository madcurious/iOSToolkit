//
//  BRDateUtilsTest_EndOfMonth.swift
//  BedrockTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
@testable import Bedrock

class BRDateUtilsTest_EndOfMonth: BRDateUtilsTest {
    
    fileprivate func doTest(date: (day: Int, month: Int, year: Int), expected: (day: Int, month: Int, year: Int)) {
        let testDate = makeDate(day: date.day, month: date.month, year: date.year)
        let resultDate = DateUtil.endOfMonth(for: testDate)
        let components = significantComponents(from: resultDate)
        assertEqual(components: components, day: expected.day, month: expected.month, year: expected.year, hour: 23, minute: 59, second: 59)
    }
    
    func test_30DayMonth_shouldSucceed() {
        doTest(date: (1, 9, 2017), expected: (30, 9, 2017))
        doTest(date: (13, 9, 2017), expected: (30, 9, 2017))
        doTest(date: (30, 9, 2017), expected: (30, 9, 2017))
    }
    
    func test_31DayMonth_shouldSucceed() {
        doTest(date: (1, 7, 2017), expected: (31, 7, 2017))
        doTest(date: (20, 7, 2017), expected: (31, 7, 2017))
        doTest(date: (31, 7, 2017), expected: (31, 7, 2017))
    }
    
    func test_nonLeapYearFebruary_shouldSucceed() {
        doTest(date: (1, 2, 2017), expected: (28, 2, 2017))
        doTest(date: (26, 2, 2017), expected: (28, 2, 2017))
        doTest(date: (28, 2, 2017), expected: (28, 2, 2017))
    }
    
    func test_leapYearFebruary_shouldSucceed() {
        doTest(date: (1, 2, 2016), expected: (29, 2, 2016))
        doTest(date: (16, 2, 2016), expected: (29, 2, 2016))
        doTest(date: (28, 2, 2016), expected: (29, 2, 2016))
        doTest(date: (29, 2, 2016), expected: (29, 2, 2016))
    }
    
}
