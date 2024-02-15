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

    @NSManaged public var body: String?
    @NSManaged public var id: UUID?
    @NSManaged public var offset: Float
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var plant: Plant?

}

extension Note : Identifiable {

}
