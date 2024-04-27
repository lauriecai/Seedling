//
//  CoreDataManager.swift
//  Seedling
//
//  Created by Laurie Cai on 2/1/24.
//

import CoreData
import Foundation
import SwiftUI

class CoreDataManager {
	
	static let shared = CoreDataManager()
	
	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	
	init() {
		container = NSPersistentContainer(name: "Seedling")
		container.loadPersistentStores { description, error in
			if let error = error {
				print("-----\nError loading Core Data. \(error)")
			}
		}
		context = container.viewContext
	}
	
// 	MARK: - Sort variables

	private var sortByNewest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: false)
	}

	private var sortByOldest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: true)
	}

	private var sortByName: NSSortDescriptor {
		NSSortDescriptor(key: "name", ascending: true)
	}
	
// 	MARK: - Save function
	
	func save() {
		do {
			try context.save()
		} catch let error {
			print("Error saving to Core Data. \(error)")
		}
	}
	
// 	MARK: - Plant functions
	
	func requestPlants() -> NSFetchRequest<Plant> {
		let request = NSFetchRequest<Plant>(entityName: "Plant")
		request.sortDescriptors = [sortByName]
		
		return request
	}
	
	func addPlant(name: String, variety: String, stage: String, type: String) {
		let newPlant = Plant(context: context)
		newPlant.id = UUID()
		newPlant.name = name
		newPlant.variety = variety
		newPlant.stage = stage
		newPlant.type = type
		
		createPlantAddedEvent(for: newPlant)
		
		save()
	}
	
	func addStageUpdate(plant: Plant, newStage: String) {
		plant.stage = newStage
		createPlantUpdatedEvent(for: plant, newStage: newStage)
		
		save()
	}
	
	func updatePlantName(for plant: Plant, name: String, variety: String) {
		plant.name = name
		plant.variety = variety
		
		save()
	}
	
	func deletePlant(plant: Plant) {
		context.delete(plant)
		save()
	}
	
// 	MARK: - Note functions
	
	func requestNotes(for plant: Plant? = nil) -> NSFetchRequest<Note> {
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}
	
	func addNote(for plant: Plant, title: String, body: String) {
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

	func requestEvents(for plant: Plant? = nil) -> NSFetchRequest<Event> {
		let request = NSFetchRequest<Event>(entityName: "Event")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}

	private func createPlantAddedEvent(for plant: Plant) {
		let newEvent = Event(context: context)
		newEvent.plant = plant
		newEvent.id = UUID()
		newEvent.timestamp = Date()
		newEvent.title = "\(plant.wrappedFullNameSentence) has been added to the garden!"
		
		save()
	}

	private func createPlantUpdatedEvent(for plant: Plant, newStage: String) {
		let newEvent = Event(context: context)
		newEvent.plant = plant
		newEvent.id = UUID()
		newEvent.timestamp = Date()
		
		let newStage = PlantStage(rawValue: newStage)!
		newEvent.title = "Your \(plant.wrappedFullNameSentence) \(newStage.updateMessage)"
		
		save()
	}
	
	func deleteEvent(event: Event) {
		context.delete(event)
		save()
	}
}
