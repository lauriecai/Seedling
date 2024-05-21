//
//  Task+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 5/20/24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var reminderDate: Date?
    @NSManaged public var reminderTime: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var category: TaskCategory?

}

extension Task : Identifiable {

}
