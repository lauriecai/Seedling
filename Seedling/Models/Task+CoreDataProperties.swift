//
//  Task+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 5/23/24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var category: TaskCategory?
	
	public var wrappedID: UUID {
		id ?? UUID()
	}
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
	
	public var customHash: Int {
		var hasher = Hasher()
		hasher.combine(self.id)
		hasher.combine(self.title)
		hasher.combine(self.isCompleted)
		
		return hasher.finalize()
	}
}

extension Task : Identifiable {

}
