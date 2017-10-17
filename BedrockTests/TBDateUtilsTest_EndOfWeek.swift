//
//  TBDateUtilsTest_EndOfWeek.swift
//  MoldTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import Foundation
import Mold

class TBDateUtilsTest_EndOfWeek: TBDateUtilsTest {
    
    fileprivate func doTest(date: (day: Int, month: Int, year: Int),
                            firstWeekday: Int,
                            expected: (day: Int, month: Int, year: Int)) {
        let testDate = makeDate(day: date.day, month: date.month, year: date.year)
        let resultDate = TBDateUtils.endOfWeek(for: testDate, firstWeekday: firstWeekday)
        let components = significantComponents(from: resultDate)
        assertEqual(components: components, day: expected.day, month: expected.month, year: expected.year, hour: 23, minute: 59, second: 59)
    }
    
    // MARK: - Dates within the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 1, expected: (21, 10, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 2, expected: (15, 10, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (15, 10, 2017), firstWeekday: 7, expected: (20, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 1, expected: (14, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 2, expected: (15, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (9, 10, 2017), firstWeekday: 7, expected: (13, 10, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 1, expected: (23, 9, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 2, expected: (24, 9, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_shouldSucceed() {
        doTest(date: (23, 9, 2017), firstWeekday: 7, expected: (29, 9, 2017))
    }
    
    // MARK: - Dates that cross the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (4, 6, 2017), firstWeekday: 1, expected: (10, 6, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (4, 6, 2017), firstWeekday: 2, expected: (4, 6, 2017))
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (4, 6, 2017), firstWeekday: 7, expected: (9, 6, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 8, 2017), firstWeekday: 1, expected: (2, 9, 2017))
        doTest(date: (25, 9, 2017), firstWeekday: 1, expected: (30, 9, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 8, 2017), firstWeekday: 2, expected: (3, 9, 2017))
        doTest(date: (25, 9, 2017), firstWeekday: 2, expected: (1, 10, 2017))
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 8, 2017), firstWeekday: 7, expected: (1, 9, 2017))
        doTest(date: (25, 9, 2017), firstWeekday: 7, expected: (29, 9, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 9, 2017), firstWeekday: 1, expected: (30, 9, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 9, 2017), firstWeekday: 2, expected: (1, 10, 2017))
    }
    
    func test_dateIsThursday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        doTest(date: (28, 9, 2017), firstWeekday: 7, expected: (29, 9, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 7, 2017), firstWeekday: 1, expected: (1, 7, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        doTest(date: (1, 7, 2017), firstWeekday: 2, expected: (2, 7, 2017))
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_isCrossingmonth_shouldSucceed() {
        doTest(date: (1, 7, 2017), firstWeekday: 7, expected: (7, 7, 2017))
    }
    
}
