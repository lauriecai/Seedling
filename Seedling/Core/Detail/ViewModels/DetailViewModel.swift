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
	
	// Detail View
	@Published var plant: Plant
	@Published var posts: [PlantPost] = []
	
	// Detail View Segues
	@Published var showAddNoteLoadingView: Bool = false
	
	// Add Note View
	@Published var noteTitle: String = ""
	@Published var noteBodyText: String = ""
	@Published var plantStage: PlantStage
	@Published var selectedStageIndex: Int
	@Published var plantStageUpdated: Bool = false
	
	@Published var editingExistingNote: Bool = false
	@Published var noteEdited: Bool = false
	
	// Add Note View Segues
	@Published var showNoteActionSheet: Bool = false
	@Published var selectedNote: Note? = nil
	
	@Published var showEventActionSheet: Bool = false
	@Published var selectedEvent: Event? = nil
	
	init(plant: Plant) {
		self.plant = plant
		
		// Add Note View
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		plantStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
	}
	
//	MARK: - Post functions
	
	func fetchPosts(for plant: Plant) {
		let notes = fetchNotes(for: plant) ?? []
		let events = fetchEvents(for: plant) ?? []

		let notesAndEventsAsPosts = notes.map { PlantPost(type: .note($0)) } + events.map { PlantPost(type: .event($0)) }
	
		posts = notesAndEventsAsPosts.sorted { $0.timestamp > $1.timestamp }
	}
	
//	MARK: - Plant functions
	
	func updatePlantStage(plant: Plant, newStage: PlantStage) {
		manager.addStageUpdate(plant: plant, newStage: newStage.rawValue)
	}
	
//	MARK: - Note functions
	
	private func fetchNotes(for plant: Plant) -> [Note]? {
		let request = manager.requestNotes(for: plant)
		
		do {
			return try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
			return nil
		}
	}
	
	func addNote(for plant: Plant, title: String, body: String) {
		manager.addNote(for: plant, title: title, body: body)
		fetchPosts(for: plant)
	}
	
	func deleteNote(note: Note) {
		manager.deleteNote(note: note)
		fetchPosts(for: plant)
	}
	
	func resetAddNoteFormInputs() {
		resetTitleAndBodyTextFields()
		resetStageUpdatedFlag()
	}
	
	private func resetTitleAndBodyTextFields() {
		noteTitle = ""
		noteBodyText = ""
	}
	
	private func resetStageUpdatedFlag() {
		plantStageUpdated = false
	}
	
//	MARK: - Event functions
	
	private func fetchEvents(for plant: Plant) -> [Event]? {
		let request = manager.requestEvents(for: plant)
		
		do {
			return try manager.context.fetch(request)
		} catch let error {
			print("Error fetching events from Core Data. \(error)")
			return nil
		}
	}
	
	func deleteEvent(event: Event) {
		manager.deleteEvent(event: event)
		fetchPosts(for: plant)
	}
}
