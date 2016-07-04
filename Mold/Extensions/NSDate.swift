//
//  NSDate.swift
//  Mold
//
//  Created by Matt Quiros on 7/13/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSDate {
    
    /**
     Returns the same date with the time set to 12 midnight, the very first moment of the date.
     */
    public func firstMoment() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self)
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let firstMoment = calendar.dateFromComponents(dateComponents)!
        return firstMoment
    }
    
    public func lastMoment() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self)
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59
        
        let firstMoment = calendar.dateFromComponents(dateComponents)!
        return firstMoment
    }
    
    public func isSameDayAsDate(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components: NSCalendarUnit = [.Month, .Day, .Year]
        
        let thisDate = calendar.components(components, fromDate: self)
        let otherDate = calendar.components(components, fromDate: date)
        
        return thisDate.month == otherDate.month &&
            thisDate.day == otherDate.day &&
            thisDate.year == otherDate.year
    }
    
    public func isSameWeekAsDate(date: NSDate, whenFirstWeekdayIs weekday: Int) -> Bool {
        let calendar = NSCalendar.currentCalendar().copy() as! NSCalendar
        calendar.firstWeekday = weekday
        
        var interval = NSTimeInterval(0)
        var firstDayInWeekOfSelf: NSDate?
        var firstDayInWeekOfDate: NSDate?
        calendar.rangeOfUnit(.WeekOfYear, startDate: &firstDayInWeekOfSelf, interval: &interval, forDate: self)
        calendar.rangeOfUnit(.WeekOfYear, startDate: &firstDayInWeekOfDate, interval: &interval, forDate: date)
        
        return firstDayInWeekOfSelf!.isSameDayAsDate(firstDayInWeekOfDate!)
    }
    
    public func isSameMonthAsDate(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components: NSCalendarUnit = [.Month, .Year]
        
        let thisDate = calendar.components(components, fromDate: self)
        let otherDate = calendar.components(components, fromDate: date)
        
        return thisDate.month == otherDate.month &&
            thisDate.year == otherDate.year
    }
    
    public func isSameYearAsDate(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components: NSCalendarUnit = [.Year]
        
        let thisDate = calendar.components(components, fromDate: self)
        let otherDate = calendar.components(components, fromDate: date)
        
        return thisDate.year == otherDate.year
    }
    
}