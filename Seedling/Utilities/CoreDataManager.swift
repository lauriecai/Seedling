//
//  CoreDataManager.swift
//  Seedling
//
//  Created by Laurie Cai on 2/1/24.
//

import CoreData
import Foundation

class CoreDataManager {
	
	static let shared = CoreDataManager()
	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	
	init() {
		container = NSPersistentContainer(name: "Seedling")
		context = container.viewContext
		
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Error loading Core Data.")
			} else {
				print("Successfully loaded Core Data.")
			}
		}
	}
}
