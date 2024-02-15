//
//  Plant+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 2/15/24.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
	@NSManaged public var variety: String?
	@NSManaged public var stage: String?
	@NSManaged public var type: String?
    @NSManaged public var notes: NSSet?
	@NSManaged public var offset: Float
	
	public var wrappedName: String {
		name ?? ""
	}
	
	public var wrappedVariety: String {
		variety ?? ""
	}

	public var wrappedStage: String {
		stage ?? ""
	}
	
	public var wrappedType: String {
		type ?? ""
	}
	
	public var notesArray: [Note] {
		let set = notes as? Set<Note> ?? []
		
		return set.sorted {
			$0.wrappedTimestamp > $1.wrappedTimestamp
		}
	}
}

// MARK: Generated accessors for notes
extension Plant {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Plant : Identifiable {

}
