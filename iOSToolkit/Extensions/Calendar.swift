//
//  Calendar.swift
//  iOSToolkit
//
//  Created by Matt Quiros on 19/12/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import Foundation

extension Calendar {
	
	/// Returns the number of days in a month as defined in this calendar.
	func numberOfDaysInMonth(of date: Date) -> Int {
		return range(of: .day, in: .month, for: date)!.upperBound - 1
	}
	
}
