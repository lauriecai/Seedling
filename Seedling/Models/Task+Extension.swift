//
//  Task+Extension.swift
//  Seedling
//
//  Created by Laurie Cai on 6/11/24.
//

import Foundation

extension Task {
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
	
	public var customHash: Int {
		var hasher = Hasher()
		hasher.combine(self.wrappedTitle)
		hasher.combine(self.isCompleted)
		
		return hasher.finalize()
	}
}
