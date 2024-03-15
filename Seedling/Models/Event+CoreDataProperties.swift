//
//  Event+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 3/15/24.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

	@NSManaged public var plant: Plant?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}

}

extension Event : Identifiable {

}
