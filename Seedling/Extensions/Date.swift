//
//  Date.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import Foundation

extension Date {
	
	/// Creates a formatter that converts a Date into a baseline format based on local timezone
	private func createFormatter() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.locale = Locale.current
		
		return formatter
	}
	
	/// Converts a date into day of the week and date format
	/// ```
	/// Converts 2022-02-19 12:34:56 +0000 to Monday, February 19
	/// ```
	private var dayAndDateFormatter: DateFormatter {
		let formatter = createFormatter()
		formatter.dateFormat = "EEEE, MMMM d"
		
		return formatter
	}
	
	/// Converts a date into date and time format
	/// ```
	/// Converts 2022-02-19 12:34:56 +0000 to February 19, 2023 12:34pm
	/// ```
	private var dateAndTimeFormatter: DateFormatter {
		let formatter = createFormatter()
		formatter.dateFormat = "MMMM d, yyyy h:mma"
		
		return formatter
	}
	
	/// Converts a day-and-date-formatted date into a String
	/// ```
	/// Converts Monday, February 19 to "Monday, February 19"
	/// ```
	func asDayAndDate() -> String {
		let currentDate = Date()
		return dayAndDateFormatter.string(from: currentDate)
	}
	
	/// Converts a date-and-time-formatted date into a String
	/// ```
	/// Converts February 19, 2023 12:34pm to "February 19, 2023 12:34pm"
	/// ```
	func asDateAndTime() -> String {
		let currentDate = Date()
		return dateAndTimeFormatter.string(from: currentDate)
	}
}
