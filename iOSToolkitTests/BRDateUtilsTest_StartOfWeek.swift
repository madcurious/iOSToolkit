//
//  BRDateUtilsTest_StartOfWeek.swift
//  iOSToolkitTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
@testable import Bedrock

class BRDateUtilsTest_StartOfWeek: BRDateUtilsTest {
    
    fileprivate func doTest(date: (day: Int, month: Int, year: Int),
                            firstWeekday: Int,
                            expected: (day: Int, month: Int, year: Int)) {
        let testDate = makeDate(day: date.day, month: date.month, year: date.year)
        let resultDate = DateUtil.startOfWeek(for: testDate, firstWeekday: firstWeekday)
        let components = significantComponents(from: resultDate)
        assertEqual(components: components, day: expected.day, month: expected.month, year: expected.year, hour: 0, minute: 0, second: 0)
    }
    
    // MARK: - Dates within the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 1, expected: (15, 10, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 2, expected: (9, 10, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 7, expected: (14, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 1, expected: (8, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 2, expected: (9, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 7, expected: (7, 10, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 1, expected: (17, 9, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 2, expected: (18, 9, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 7, expected: (23, 9, 2017))
    }
    
    // MARK: - Dates that cross the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 10, 2017), firstWeekday: 1, expected: (1, 10, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 10, 2017), firstWeekday: 2, expected: (25, 9, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 10, 2017), firstWeekday: 7, expected: (30, 9, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (2, 10, 2017), firstWeekday: 1, expected: (1, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (2, 10, 2017), firstWeekday: 2, expected: (2, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (2, 10, 2017), firstWeekday: 7, expected: (30, 9, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 6, 2017), firstWeekday: 1, expected: (28, 5, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 6, 2017), firstWeekday: 2, expected: (29, 5, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 6, 2017), firstWeekday: 7, expected: (27, 5, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (3, 6, 2017), firstWeekday: 1, expected: (28, 5, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (3, 6, 2017), firstWeekday: 2, expected: (29, 5, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_isCrossingmonth_shouldSucceed() {
        doTest(date: (3, 6, 2017), firstWeekday: 7, expected: (3, 6, 2017))
    }
    
}
