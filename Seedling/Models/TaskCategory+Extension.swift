//
//  TaskCategory+Extension.swift
//  Seedling
//
//  Created by Laurie Cai on 6/11/24.
//

import Foundation

extension TaskCategory {
	
	public var wrappedName: String {
		name ?? ""
	}
	
	public var tasksList: [Task] {
		let set = tasks as? Set<Task> ?? []
		return set.sorted { $0.wrappedTimestamp < $1.wrappedTimestamp }
	}
	
	public var customHash: Int {
		var hasher = Hasher()
		
		for task in tasksList {
			hasher.combine(task.wrappedTitle)
			hasher.combine(task.isCompleted)
		}
		
		return hasher.finalize()
	}
}
