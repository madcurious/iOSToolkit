//
//  TBDateUtilsTest_EndOfDay.swift
//  MoldTests
//
//  Created by Matt Quiros on 03/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import XCTest
import Mold

class TBDateUtilsTest_EndOfDay: TBDateUtilsTest {
    
    func testEndOfDay_leapYearDate_shouldSucceed() {
        let date = makeDate(day: 29, month: 2, year: 2016)
        
        let endOfDay = TBDateUtils.endOfDay(for: date)
        let comps = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: endOfDay)
        XCTAssertEqual(comps.day, 29)
        XCTAssertEqual(comps.month, 2)
        XCTAssertEqual(comps.year, 2016)
        XCTAssertEqual(comps.hour, 23)
        XCTAssertEqual(comps.minute, 59)
        XCTAssertEqual(comps.second, 59)
    }
    
}
