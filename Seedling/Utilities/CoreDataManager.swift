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
			} else {
				print("-----\nSuccessfully loaded Core Data.")
			}
		}
		context = container.viewContext
	}
	
// 	MARK: - Sort variables
	
	/// Returns an NSSortDescriptor specifying sort by newest first
	private var sortByNewest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: false)
	}
	
	/// Returns an NSSortDescriptor specifying sort by oldest first
	private var sortByOldest: NSSortDescriptor {
		NSSortDescriptor(key: "timestamp", ascending: true)
	}
	
	/// Returns an NSSortDescriptor specifying sort by alphabetical order
	private var sortByName: NSSortDescriptor {
		NSSortDescriptor(key: "name", ascending: true)
	}
	
// 	MARK: - Save function
	
	/// Saves contextual working changes to Core Data
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
	
	func addPlant(type: String, name: String, variety: String, stage: String) {
		let newPlant = Plant(context: context)
		newPlant.id = UUID()
		newPlant.type = type
		newPlant.name = name
		newPlant.variety = variety
		newPlant.stage = stage
		
		createPlantAddedEvent(for: newPlant)
		
		save()
	}
	
	func updatePlant(plant: Plant, newStage: String) {
		plant.stage = newStage
		createPlantUpdatedEvent(for: plant, newStage: newStage)
		
		save()
	}
	
	func deletePlant(plant: Plant) {
		context.delete(plant)
		save()
	}
	
// 	MARK: - Note functions
	
	/// Returns an NSFetchRequest for either all notes or notes of a specified plant
	func requestNotes(for plant: Plant? = nil) -> NSFetchRequest<Note> {
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}
	
	/// Creates a new note associated with a specific plant and saves to Core Data
	func addNote(for plant: Plant, title: String, body: String) {
		let newNote = Note(context: context)
		newNote.plant = plant
		newNote.id = UUID()
		newNote.timestamp = Date()
		newNote.title = title
		newNote.body = body
		
		save()
	}
	
	/// Deletes a specified note from Core Data
	func deleteNote(note: Note) {
		context.delete(note)
		save()
	}
	
	// MARK: - Event functions
	
	/// Returns an  NSFetchRequest for either all events or events of a specified plant
	func requestEvents(for plant: Plant? = nil) -> NSFetchRequest<Event> {
		let request = NSFetchRequest<Event>(entityName: "Event")
		request.sortDescriptors = [sortByNewest]
		
		if let plant = plant {
			request.predicate = NSPredicate(format: "plant == %@", plant)
		}
		
		return request
	}
	
	/// Creates a new event when a new plant is added
	private func createPlantAddedEvent(for plant: Plant) {
		let newEvent = Event(context: context)
		newEvent.plant = plant
		newEvent.id = UUID()
		newEvent.timestamp = Date()
		newEvent.title = "\(plant.wrappedFullNameSentence) has been added to the garden!"
		
		save()
	}
	
	/// Creates a new event when an existing plant's stage is updated
	private func createPlantUpdatedEvent(for plant: Plant, newStage: String) {
		let newEvent = Event(context: context)
		newEvent.plant = plant
		newEvent.id = UUID()
		newEvent.timestamp = Date()
		newEvent.title = "Stage updated: \(newStage)"
		
		save()
	}
	
	func deleteEvent(event: Event) {
		context.delete(event)
		save()
	}
}
