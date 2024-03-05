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
	
	@Published var allNotes: [Note] = []
	
	init() {
		fetchAllNotes()
	}
	
	private func fetchAllNotes() {
		let request = NSFetchRequest<Note>(entityName: "Note")
		let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
		request.sortDescriptors = [sortDescriptor]
		
		do {
			allNotes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
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
