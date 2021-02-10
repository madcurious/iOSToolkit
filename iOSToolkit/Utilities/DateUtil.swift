//
//  DateUtil.swift
//  iOSToolkit
//
//  Created by Matthew Quiros on 03/10/2017.
//  Copyright © 2017 Matthew Quiros. All rights reserved.
//

import Foundation

final class DateUtil {
	
	class func isSameDay(date1: Date, date2: Date, inCalendar calendar: Calendar) -> Bool {
		if calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame {
			return true
		}
		return false
	}
	
	class func isSameWeek(date1: Date, date2: Date, firstWeekday: Int, inCalendar calendar: Calendar = Calendar.current) -> Bool {
		var calendar = calendar
		calendar.firstWeekday = firstWeekday
		calendar.minimumDaysInFirstWeek = 7
		
		if calendar.compare(date1, to: date2, toGranularity: .weekOfYear) == .orderedSame {
			return true
		}
		return false
	}
	
	class func isSameMonth(date1: Date, date2: Date, inCalendar calendar: Calendar = Calendar.current) -> Bool {
		if calendar.compare(date1, to: date2, toGranularity: .month) == .orderedSame {
			return true
		}
		return false
	}
	
	class func isSameYear(date1: Date, date2: Date, inCalendar calendar: Calendar = Calendar.current) -> Bool {
		if calendar.compare(date1, to: date2, toGranularity: .year) == .orderedSame {
			return true
		}
		return false
	}
	
	class func endOfDay(for date: Date, inCalendar calendar: Calendar = Calendar.current) -> Date {
		var components = DateComponents()
		components.day = 1
		components.second = -1
		
		let startOfDay = calendar.startOfDay(for: date)
		return calendar.date(byAdding: components, to: startOfDay)!
	}
	
	class func endOfWeek(for date: Date, firstWeekday: Int, inCalendar calendar: Calendar = Calendar.current) -> Date {
		let startOfWeek = self.startOfWeek(for: date, firstWeekday: firstWeekday)
		
		var components = calendar.dateComponents([.weekOfYear], from: date)
		components.weekOfYear = 1
		components.day = -1
		
		let endDateOfWeek = calendar.date(byAdding: components, to: startOfWeek)!
		return self.endOfDay(for: endDateOfWeek)
	}
	
	class func endOfMonth(for date: Date, inCalendar calendar: Calendar = Calendar.current) -> Date {
		let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: date)!.upperBound - 1
		let endDateOfMonth = calendar.date(bySetting: .day, value: numberOfDaysInMonth, of: date)!
		return self.endOfDay(for: endDateOfMonth)
	}
	
	class func startOfWeek(for date: Date, firstWeekday: Int, inCalendar calendar: Calendar = Calendar.current) -> Date {
		var calendar = calendar
		calendar.firstWeekday = firstWeekday
		calendar.minimumDaysInFirstWeek = 7
		let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
		
		let startDateOfWeek = calendar.date(from: components)!
		return calendar.startOfDay(for: startDateOfWeek)
	}
	
	class func startOfMonth(for date: Date, inCalendar calendar: Calendar = Calendar.current) -> Date {
		var components = calendar.dateComponents([.year, .month, .day], from: date)
		components.day = 1
		
		let startDateOfMonth = calendar.date(from: components)!
		return calendar.startOfDay(for: startDateOfMonth)
	}
	
}
