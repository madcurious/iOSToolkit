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
    
    func test_dateIsSaturday_firstWeekdayIsSunday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 17)
        XCTAssertEqual(comps.month, 9)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
    func test_dateIsSunday_firstWeekdayIsSunday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 1)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 1)
        XCTAssertEqual(comps.month, 10)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
    func test_dateIsSunday_firstWeekdayIsMonday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 25)
        XCTAssertEqual(comps.month, 9)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
    func test_dateIsSunday_firstWeekdayIsSaturday_isCrossingMonth_shouldSucceed() {
        let testDate = makeDate(day: 1, month: 10, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 30)
        XCTAssertEqual(comps.month, 9)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsMonday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 2)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 18)
        XCTAssertEqual(comps.month, 9)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
    func test_dateIsSaturday_firstWeekdayIsSaturday_shouldSucceed() {
        let testDate = makeDate(day: 23, month: 9, year: 2017)
        let resultDate = TBDateUtils.startOfWeek(for: testDate, firstWeekday: 7)
        let comps = significantComponents(from: resultDate)
        
        XCTAssertEqual(comps.day, 23)
        XCTAssertEqual(comps.month, 9)
        XCTAssertEqual(comps.year, 2017)
        XCTAssertEqual(comps.hour, 0)
        XCTAssertEqual(comps.minute, 0)
        XCTAssertEqual(comps.second, 0)
    }
    
}
