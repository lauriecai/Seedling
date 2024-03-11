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
	
	// plant functions
	func requestAllPlants() -> NSFetchRequest<Plant> {
		let request = NSFetchRequest<Plant>(entityName: "Plant")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		request.sortDescriptors = [sortDescriptor]
		
		return request
	}
	
	func addPlant(type: String, name: String, variety: String, stage: String) {
		let newPlant = Plant(context: context)
		newPlant.id = UUID()
		newPlant.type = type
		newPlant.name = name
		newPlant.variety = variety
		newPlant.stage = stage
		newPlant.offset = 0
		
		save()
	}
	
	func deletePlant(plant: Plant) {
		context.delete(plant)
		save()
	}
	
	// note functions
	func requestNotes(for plant: Plant) -> NSFetchRequest<Note> {
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.predicate = NSPredicate(format: "plant == %@", plant)
		
		let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
		request.sortDescriptors = [sortDescriptor]
		
		return request
	}
	
	func requestAllNotes() -> NSFetchRequest<Note> {
		let request = NSFetchRequest<Note>(entityName: "Note")
		let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
		request.sortDescriptors = [sortDescriptor]
		
		return request
	}
	
	func addNote(plant: Plant, title: String, body: String) {
		let newNote = Note(context: context)
		newNote.plant = plant
		newNote.id = UUID()
		newNote.timestamp = Date()
		newNote.title = title
		newNote.body = body
		newNote.offset = 0
		
		save()
	}
	
	// card functions
	func resetOffsets(plant: Plant) {
		plant.offset = 0
		save()
	}
}
