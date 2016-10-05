//
//  Date.swift
//  Mold
//
//  Created by Matt Quiros on 7/13/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

fileprivate let kCalendar = Calendar.current

public extension Date {
    
    /**
     Returns the same date with the time set to 12 midnight, the very first moment of the date.
     */
    
    public func startOfDay() -> Date {
        return kCalendar.startOfDay(for: self)
    }
    
    public func endOfDay() -> Date {
        var dateComponents = kCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59
        
        let lastMoment = kCalendar.date(from: dateComponents)!
        return lastMoment
    }
    
    public func isSameDayAsDate(_ date: Date) -> Bool {
        if kCalendar.compare(self, to: date, toGranularity: .day) == .orderedSame {
            return true
        }
        return false
    }
    
    public func isSameWeekAsDate(_ date: Date, whenFirstWeekdayIs weekday: Int) -> Bool {
        var calendar = Calendar.current // Creates an instance different from kCalendar.
        calendar.firstWeekday = weekday
        
        if calendar.compare(self, to: date, toGranularity: .weekOfYear) == .orderedSame {
            return true
        }
        return false
    }
    
    public func isSameMonthAsDate(_ date: Date) -> Bool {
        if kCalendar.compare(self, to: date, toGranularity: .month) == .orderedSame {
            return true
        }
        return false
    }
    
    public func isSameYearAsDate(_ date: Date) -> Bool {
        if kCalendar.compare(self, to: date, toGranularity: .year) == .orderedSame {
            return true
        }
        return false
    }
    
}
