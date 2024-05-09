//
//  Photo+CoreDataProperties.swift
//  Seedling
//
//  Created by Laurie Cai on 5/9/24.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var name: String?
    @NSManaged public var plant: Plant?

}

extension Photo : Identifiable {

}
