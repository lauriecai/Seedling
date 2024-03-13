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
	
	func fetchNotes(for plant: Plant) {
		let request = manager.requestNotes(for: plant)
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func deleteNote(note: Note) {
		if let savedNote = notes.first(where: { $0.id == note.id }) {
			manager.deleteNote(note: savedNote)
		}
	}
}
