//
//  NSDate.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 7/13/15.
//  Copyright © 2015 Matt Quiros. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public func isSameDayAsDate(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components: NSCalendarUnit = [.Month, .Day, .Year]
        
        let thisDate = calendar.components(components, fromDate: self)
        let otherDate = calendar.components(components, fromDate: date)
        
        return thisDate.month == otherDate.month &&
            thisDate.day == otherDate.day &&
            thisDate.year == otherDate.year
    }
    
}