//
//  TBDateUtilsTest_StartOfWeek.swift
//  MoldTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
import Mold

class TBDateUtilsTest_StartOfWeek: TBDateUtilsTest {
    
    fileprivate func doTest(dateArgs: (day: Int, month: Int, year: Int),
                            firstWeekday: Int,
                            expected: (day: Int, month: Int, year: Int, hour: Int, minute: Int, second: Int)) {
        let testDate = makeDate(day: dateArgs.day, month: dateArgs.month, year: dateArgs.year)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: firstWeekday)
        let components = significantComponents(from: resultDate)
        assertEqual(components: components, day: expected.day, month: expected.month, year: expected.year, hour: expected.hour, minute: expected.minute, second: expected.second)
    }
    
    // MARK: - Dates within the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(dateArgs: (15, 10, 2017), firstWeekday: 1, expected: (15, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(dateArgs: (15, 10, 2017), firstWeekday: 2, expected: (9, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(dateArgs: (15, 10, 2017), firstWeekday: 7, expected: (14, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(dateArgs: (9, 10, 2017), firstWeekday: 1, expected: (8, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(dateArgs: (9, 10, 2017), firstWeekday: 2, expected: (9, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(dateArgs: (9, 10, 2017), firstWeekday: 7, expected: (7, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(dateArgs: (23, 9, 2017), firstWeekday: 1, expected: (17, 9, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(dateArgs: (23, 9, 2017), firstWeekday: 2, expected: (18, 9, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(dateArgs: (23, 9, 2017), firstWeekday: 7, expected: (23, 9, 2017, 0, 0, 0))
    }
    
    // MARK: - Dates that cross the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 10, 2017), firstWeekday: 1, expected: (1, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 10, 2017), firstWeekday: 2, expected: (25, 9, 2017, 0, 0, 0))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 10, 2017), firstWeekday: 7, expected: (30, 9, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (2, 10, 2017), firstWeekday: 1, expected: (1, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (2, 10, 2017), firstWeekday: 2, expected: (2, 10, 2017, 0, 0, 0))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (2, 10, 2017), firstWeekday: 7, expected: (30, 9, 2017, 0, 0, 0))
    }
    
    func test_dateIsThursday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 6, 2017), firstWeekday: 1, expected: (28, 5, 2017, 0, 0, 0))
    }
    
    func test_dateIsThursday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 6, 2017), firstWeekday: 2, expected: (29, 5, 2017, 0, 0, 0))
    }
    
    func test_dateIsThursday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (1, 6, 2017), firstWeekday: 7, expected: (27, 5, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (3, 6, 2017), firstWeekday: 1, expected: (28, 5, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(dateArgs: (3, 6, 2017), firstWeekday: 2, expected: (29, 5, 2017, 0, 0, 0))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_isCrossingmonth_shouldSucceed() {
        doTest(dateArgs: (3, 6, 2017), firstWeekday: 7, expected: (3, 6, 2017, 0, 0, 0))
    }
    
}
