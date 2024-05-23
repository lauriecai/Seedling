//
//  Task+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 5/22/24.
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

	public var wrappedId: UUID {
		id ?? UUID()
	}
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
}

extension Task : Identifiable {

}
