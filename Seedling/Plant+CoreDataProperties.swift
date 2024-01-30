//
//  Plant+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 1/29/24.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var stage: String?
    @NSManaged public var variety: String?
    @NSManaged public var note: NSSet?

}

// MARK: Generated accessors for note
extension Plant {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Note)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Note)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}

extension Plant : Identifiable {

}
