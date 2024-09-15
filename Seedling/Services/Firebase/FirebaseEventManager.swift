//
//  FirebaseEventManager.swift
//  Seedling
//
//  Created by Laurie Cai on 9/15/24.
//

import Foundation

final class FirebaseEventManager {
	
	static let shared = FirebaseEventManager()
	private init() { }
	
	func logEvent(name: String) {
		AnalyticsManager.shared.logEvent(name: name)
		CrashManager.shared.addLog(message: name)
	}
}
