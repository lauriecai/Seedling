//
//  PerformanceManager.swift
//  Seedling
//
//  Created by Laurie Cai on 9/15/24.
//

import FirebasePerformance
import Foundation

final class PerformanceManager {
	
	static let shared = PerformanceManager()
	private init() { }
	
	private var traces: [String: Trace] = [:]
	
	func startTrace(name: String) {
		let trace = Performance.startTrace(name: name)
		traces[name] = trace
	}
	
	func setValue(name: String, value: Int, metric: String) {
		guard let trace = traces[name] else { return }
		trace.setValue(Int64(value), forMetric: metric)
	}
	
	func stopTrace(name: String) {
		guard let trace = traces[name] else { return }
		trace.stop()
		traces.removeValue(forKey: name)
	}
}
