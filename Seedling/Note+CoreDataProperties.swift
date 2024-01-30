//
//  Note+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 1/29/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var note: String?
    @NSManaged public var plant: Plant?

}

extension Note : Identifiable {

}
