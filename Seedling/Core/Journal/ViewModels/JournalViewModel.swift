//
//  JournalViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import CoreData
import Foundation

class JournalViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	@Published var plants: [Plant] = []
	@Published var notes: [Note] = []
	
	init() {
		fetchPlantsAndNotes()
	}
	
	private func fetchPlantsAndNotes() {
		fetchPlants()
		fetchNotes()
	}
	
//	MARK: - Plant variables
	
	/// Returns an array of plant names
	var plantNames: [String] {
		var names: [String] = []
		for plant in plants { names.append(plant.wrappedFullNameLabel) }
		
		return names
	}
	
//	MARK: - Plant functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date plants from Core Data
	func fetchPlants() {
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
//	MARK: - Note functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date notes for a specified plant from Core Data
	func fetchNotes() {
		let request = manager.requestNotes()
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
		}
	}
	
	/// Creates a new note associated with a specific plant and saves to Core Data, then refreshes the notes array
	func addNote(for plant: Plant, title: String, body: String) {
		manager.addNote(for: plant, title: title, body: body)
		fetchNotes()
	}
	
	/// Deletes a note from Core Data, then fetches notes for a specific plant
	func deleteNote(note: Note) {
		manager.deleteNote(note: note)
		fetchNotes()
	}
}
