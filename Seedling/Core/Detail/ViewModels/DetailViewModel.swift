//
//  DetailViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import CoreData
import Foundation

class DetailViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	@Published var plant: Plant
	@Published var notes: [Note] = []
	@Published var events: [Event] = []
	
	/// An array of combined notes and events
	@Published var posts: [PlantPost] = []
	
	init(plant: Plant) {
		self.plant = plant
	}
	
	//	MARK: - Post functions
	
	func fetchPosts(for plant: Plant) {
		fetchNotes(for: plant)
		fetchEvents(for: plant)
		assemblePosts(for: plant)
	}
	
	private func resetPosts() {
		posts = []
	}
	
	private func assemblePosts(for plant: Plant) {
		
		resetPosts()
		
		for event in events {
			posts.append(PlantPost(entity: .event(event)))
		}
		
		for note in notes {
			posts.append(PlantPost(entity: .note(note)))
		}
		
		posts.sort { $0.timestamp > $1.timestamp }
	}
	
//	MARK: - Plant functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Updates the plant stage
	func updatePlant(plant: Plant, newStage: PlantStage) {
		manager.updatePlant(plant: plant, newStage: newStage.rawValue)
	}
	
//	MARK: - Note functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date notes for a specified plant from Core Data
	func fetchNotes(for plant: Plant) {
		let request = manager.requestNotes(for: plant)
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
		}
	}
	
	/// Creates a new note associated with a specific plant and saves to Core Data, then refreshes the notes array
	func addNote(for plant: Plant, title: String, body: String) {
		manager.addNote(for: plant, title: title, body: body)
		fetchNotes(for: plant)
	}
	
	/// Deletes a note from Core Data, then fetches notes for a specific plant
	func deleteNote(note: Note) {
		manager.deleteNote(note: note)
		fetchNotes(for: plant)
	}
	
//	MARK: - Event functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date events for a specified plant from Core Data
	func fetchEvents(for plant: Plant) {
		let request = manager.requestEvents(for: plant)
		
		do {
			events = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching events from Core Data. \(error)")
		}
	}
	
	/// Deletes an event from Core Data, then fetches events for a specific plant
	func deleteEvent(event: Event) {
		manager.deleteEvent(event: event)
		fetchEvents(for: plant)
	}
}
