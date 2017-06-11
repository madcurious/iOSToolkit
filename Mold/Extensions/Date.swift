//
//  Date.swift
//  Mold
//
//  Created by Matt Quiros on 7/13/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension Date {
    
    /// Returns the date at 00:00:00
    public func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Returns the date at 23:59:59
    public func endOfDay() -> Date {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59
        
        let lastMoment = calendar.date(from: dateComponents)!
        return lastMoment
    }
    
    public func startOfWeek(firstWeekday: Int) -> Date {
        var calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        calendar.firstWeekday = firstWeekday
        calendar.minimumDaysInFirstWeek = 7
        return calendar.date(from: components)!
    }
    
    public func endOfWeek(firstWeekday: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.weekOfYear], from: self)
        components.weekOfYear = 1
        components.day = -1
        return calendar.date(byAdding: components, to: self.startOfWeek(firstWeekday: firstWeekday))!
    }
    
    public func startOfMonth() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.day = 1
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    public func endOfMonth() -> Date {
        let calendar = Calendar.current
        let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: self)!.upperBound - 1
        let endOfMonth = calendar.date(bySetting: .day, value: numberOfDaysInMonth, of: self)!.endOfDay()
        return endOfMonth
    }
    
    public func isSameDayAsDate(_ date: Date) -> Bool {
        if Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedSame {
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
        if Calendar.current.compare(self, to: date, toGranularity: .month) == .orderedSame {
            return true
        }
        return false
    }
    
    public func isSameYearAsDate(_ date: Date) -> Bool {
        if Calendar.current.compare(self, to: date, toGranularity: .year) == .orderedSame {
            return true
        }
        return false
    }
    
}
