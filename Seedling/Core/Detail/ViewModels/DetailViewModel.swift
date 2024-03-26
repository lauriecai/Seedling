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
	
	init(plant: Plant) {
		self.plant = plant
	}
	
//	MARK: - Note functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date notes for a specified plant from Core Data
	func fetchNotes(for plant: Plant) {
		let request = manager.requestNotes(for: plant)
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
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
}
