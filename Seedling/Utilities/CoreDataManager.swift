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
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Error loading Core Data. \(error)")
			} else {
				print("Successfully loaded Core Data.")
			}
		}
		context = container.viewContext
	}
	
	func save() {
		do {
			try context.save()
		} catch let error {
			print("Error saving to Core Data. \(error)")
		}
	}
}
