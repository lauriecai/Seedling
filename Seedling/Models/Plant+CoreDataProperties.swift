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
	
	public var wrappedName: String {
		name ?? ""
	}
	
	public var wrappedVariety: String {
		variety ?? ""
	}
	
	public var wrappedFullNameLabel: String {
		if !wrappedVariety.isEmpty {
			return "\(wrappedName): \(wrappedVariety)"
		} else {
			return "\(wrappedName)"
		}
	}
	
	public var wrappedFullNameSentence: String {
		if !wrappedVariety.isEmpty {
			return "\(wrappedVariety) \(wrappedName)"
		} else {
			return "\(wrappedName)"
		}
	}

	public var wrappedStage: String {
		stage ?? ""
	}
	
	public var wrappedType: String {
		type ?? ""
	}
	
	public var notesArray: [Note] {
		let notes = notes as? Set<Note> ?? []
		
		return notes.sorted {
			$0.wrappedTimestamp > $1.wrappedTimestamp
		}
	}
	
	public var customHash: Int {
		var hasher = Hasher()
		hasher.combine(self.id)
		hasher.combine(self.stage)
		
		return hasher.finalize()
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
