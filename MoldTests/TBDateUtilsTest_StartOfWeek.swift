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
    
    // MARK: - Dates within the month
    
    func test_dateIsSaturday_firstWeekdayIsSunday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 17, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 18, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 23, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    // MARK: - Dates that cross the month
    
    func test_dateIsSunday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 1, month: 10, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 25, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 30, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsMonday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 2, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 1, month: 10, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsMonday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 2, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 2, month: 10, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsMonday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 2, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 30, month: 9, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 3, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 28, month: 5, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 3, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 29, month: 5, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_isCrossingmonth_shouldSucceed() {
        let testDate = makeDate(day: 3, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 3, month: 6, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsThursday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 28, month: 5, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsThursday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 29, month: 5, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
    func test_dateIsThursday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 6, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        assertEqual(components: comps, day: 27, month: 5, year: 2017, hour: 0, minute: 0, second: 0)
    }
    
}
