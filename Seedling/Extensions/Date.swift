//
//  Date.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import Foundation

extension Date {
	
	/// Creates a formatter that converts a Date into the desired format based on local timezone
	private var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone.current
		formatter.locale = Locale.current
		formatter.dateFormat = "EEEE, MMMM d"
		
		return formatter
	}
	
	/// Formats current date into day of the week, month and day of the month
	/// ```
	/// Converts Monday, February 5, 2024 at 7:38:40 Pacific Standard Time into Monday, February 5
	/// ```
	func withDayAndDate() -> String {
		let currentDate = Date()
		return dateFormatter.string(from: currentDate)
	}
}
