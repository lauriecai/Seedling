//
//  TaskCategory+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 5/23/24.
//
//

import Foundation
import CoreData


extension TaskCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCategory> {
        return NSFetchRequest<TaskCategory>(entityName: "TaskCategory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSSet?

	public var wrappedID: UUID {
		id ?? UUID()
	}
	
	public var wrappedName: String {
		name ?? ""
	}
	
	public var tasksList: [Task] {
		let set = tasks as? Set<Task> ?? []
		return set.sorted { $0.wrappedTimestamp < $1.wrappedTimestamp }
	}
	
	public var customHash: Int {
		var hasher = Hasher()
//		hasher.combine(self.wrappedID)
//		hasher.combine(self.wrappedName)
		
		for task in tasksList {
			hasher.combine(task.wrappedTitle)
			hasher.combine(task.isCompleted)
		}
		
		return hasher.finalize()
	}
}

// MARK: Generated accessors for tasks
extension TaskCategory {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension TaskCategory : Identifiable {

}
