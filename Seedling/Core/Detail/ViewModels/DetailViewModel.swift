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
		let request = NSFetchRequest<Note>(entityName: "Note")
		request.predicate = NSPredicate(format: "plant == %@", plant)
		
		let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
		request.sortDescriptors = [sortDescriptor]
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	private func save() {
		manager.save()
	}
	
	func addNote(plant: Plant, title: String, body: String) {
		let newNote = Note(context: manager.context)
		newNote.plant = plant
		newNote.id = UUID()
		newNote.timestamp = Date()
		newNote.title = title
		newNote.body = body
		newNote.offset = 0
		
		save()
	}
}
