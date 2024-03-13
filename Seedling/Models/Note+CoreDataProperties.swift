//
//  Note+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 2/15/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

	@NSManaged public var plant: Plant?
    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
	@NSManaged public var body: String?
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedBody: String {
		body ?? ""
	}
}

extension Note : Identifiable {

}
