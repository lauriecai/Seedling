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
		print("detail view model assigned \(plant.wrappedName) to plant var")
		fetchNotes(for: plant)
	}
	
	private func fetchNotes(for plant: Plant) {
		print("in fetchNotes(for plant: Plant) function")
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.predicate = NSPredicate(format: "plant == %@", plant)
		
		do {
			notes = try manager.context.fetch(request)
			print("notes fetched")
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	private func save() {
		manager.save()
		fetchNotes(for: plant)
	}
	
	func addNote(plant: Plant) {
		let newNote = Note(context: manager.context)
		newNote.plant = plant
		newNote.id = UUID()
		newNote.timestamp = Date()
		newNote.title = "here's a note about my \(plant.wrappedName)!"
		newNote.body = "here's a description of something that happened today. this will probably contain events in the future but for now it's just free text."
		newNote.offset = 0
		
		save()
	}
}


