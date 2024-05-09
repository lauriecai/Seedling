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
	
	@Published var showingAddPostOptions: Bool = false
	
	// Add Note View
	@Published var noteTitle: String = ""
	@Published var noteBodyText: String = ""
	
	@Published var editingExistingNote: Bool = false
	@Published var noteEdited: Bool = false
	
	// Update Stage View
	@Published var plantStage: PlantStage
	@Published var selectedStageIndex: Int
	@Published var plantStageUpdated: Bool = false
	
	// Detail View Segues
	@Published var showingAddNoteLoadingView: Bool = false
	@Published var showingUpdateStageLoadingView: Bool = false
	@Published var showingPlantDetailsLoadingView: Bool = false
	
	// Add Note View Segues
	@Published var showNoteActionSheet: Bool = false
	@Published var selectedNote: Note? = nil
	
	@Published var showEventActionSheet: Bool = false
	@Published var selectedEvent: Event? = nil
	
	init(plant: Plant) {
		self.plant = plant
		
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
		fetchPosts(for: plant)
	}
	
	func fetchPlantStage(for plant: Plant) {
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		plantStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
	}
	
	func resetStageUpdatedFlag() {
		plantStageUpdated = false
		showingAddPostOptions = false
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
	
	func updateNoteTitleAndBody(for note: Note, title: String, body: String) {
		manager.updateNoteTitleAndBody(for: note, title: title, body: body)
		fetchPosts(for: plant)
	}
	
	func fetchExistingNoteTitleAndBody(for note: Note) {
		noteTitle = note.wrappedTitle
		noteBodyText = note.wrappedBody
	}
	
	func resetAddNoteFormInputs() {
		resetTitleAndBodyTextFields()
		editingExistingNote = false
	}
	
	func resetNoteEditedFlag() {
		noteEdited = false
	}
	
	private func resetTitleAndBodyTextFields() {
		noteTitle = ""
		noteBodyText = ""
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
