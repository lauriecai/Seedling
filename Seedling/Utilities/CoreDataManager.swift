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
	
	private var sortByNewest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: false)
	}
	
	private var sortByOldest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: true)
	}
	
	// MARK: - Plant functions
	
	func requestPlants() -> NSFetchRequest<Plant> {
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
	
	func resetOffsets(plant: Plant) {
		plant.offset = 0
		save()
	}
	
	// MARK: - Note functions
	
	/// returns a fetch request for either all notes or notes of a specified plant
	func requestNotes(for plant: Plant? = nil) -> NSFetchRequest<Note> {
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}
	
	func addNote(plant: Plant, title: String, body: String) {
		let newNote = Note(context: context)
		newNote.plant = plant
		newNote.id = UUID()
		newNote.timestamp = Date()
		newNote.title = title
		newNote.body = body
		
		save()
	}
	
	func deleteNote(note: Note) {
		context.delete(note)
		save()
	}
	
	// MARK: - Event functions
	
	/// returns a fetch request for either all events or events of a specified plant
	func requestEvents(for plant: Plant? = nil) -> NSFetchRequest<Event> {
		let request = NSFetchRequest<Event>(entityName: "Event")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}
	
	func addEvent(plant: Plant, previousStage: String, newStage: String) {
		let newEvent = Event(context: context)
		newEvent.plant = plant
		newEvent.id = UUID()
		newEvent.timestamp = Date()
		newEvent.title = "\(previousStage) to \(newStage)"
		
		save()
	}
}
