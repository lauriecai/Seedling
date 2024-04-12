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

	var plantNames: [String] {
		plants.map { $0.wrappedFullNameLabel }
	}
	
//	MARK: - Plant functions

	func fetchPlants() {
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
//	MARK: - Note functions
	
	func fetchNotes() {
		let request = manager.requestNotes()
		
		do {
			notes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
		}
	}

	func addNote(for plant: Plant, title: String, body: String) {
		manager.addNote(for: plant, title: title, body: body)
		fetchNotes()
	}

	func deleteNote(note: Note) {
		manager.deleteNote(note: note)
		fetchNotes()
	}
}
