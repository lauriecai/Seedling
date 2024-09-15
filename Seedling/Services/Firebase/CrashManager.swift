//
//  CrashManager.swift
//  Seedling
//
//  Created by Laurie Cai on 9/14/24.
//

import FirebaseCrashlytics
import Foundation

final class CrashManager {
	
	static let shared = CrashManager()
	private init() { }
	
	func addLog(message: String) {
		Crashlytics.crashlytics().log(message)
	}
}
