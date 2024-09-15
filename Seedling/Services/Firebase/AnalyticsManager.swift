//
//  AnalyticsManager.swift
//  Seedling
//
//  Created by Laurie Cai on 9/15/24.
//

import FirebaseAnalytics
import Foundation

final class AnalyticsManager {
	
	static let shared = AnalyticsManager()
	private init() { }
	
	func logEvent(name: String, parameters: [String: Any]? = nil) {
		Analytics.logEvent(name, parameters: parameters)
	}
}
