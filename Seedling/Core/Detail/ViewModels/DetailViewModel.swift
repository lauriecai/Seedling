//
//  DetailViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import CoreData
import Foundation
import SwiftUI

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
	
	// Plant Details View
	@Published var plantNameInput: String = ""
	@Published var plantVarietyInput: String = ""
	
	@Published var plantType: PlantType
	@Published var selectedTypeIndex: Int
	
	@Published var sunlightRequirementInput: String = ""
	@Published var temperatureRequirementInput: String = ""
	@Published var waterRequirementInput: String = ""
	@Published var humidityRequirementInput: String = ""
	@Published var soilRequirementInput: String = ""
	@Published var fertilizerRequirementInput: String = ""
	
	@Published var additionalCareNotesInput: String = ""
	
	@Published var plantGeneralDetailsEdited: Bool = false
	@Published var plantCareRequirementsEdited: Bool = false
	@Published var plantAdditionalCareNotesEdited: Bool = false
	
	// Detail View Segues
	@Published var showingAddNoteLoadingView: Bool = false
	@Published var showingUpdateStageLoadingView: Bool = false
	@Published var showingPlantDetailsLoadingView: Bool = false
	
	// Add Note View Segues
	@Published var showNoteActionSheet: Bool = false
	@Published var selectedNote: Note? = nil
	
	@Published var showEventActionSheet: Bool = false
	@Published var selectedEvent: Event? = nil
	
	// Plant Details Segues
	@Published var editingGeneralDetails: Bool = false
	@Published var editingCareRequirements: Bool = false
	@Published var editingAdditionalCareNotes: Bool = false
	
	init(plant: Plant) {
		self.plant = plant
		
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		plantStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
		
		let savedPlantType = PlantType(rawValue: plant.wrappedType)!
		plantType = savedPlantType
		selectedTypeIndex = PlantType.allCases.firstIndex(of: savedPlantType)!
		
		fetchPlantGeneralDetails(for: plant)
	}
	
//	MARK: - Post functions
	
	func fetchPosts(for plant: Plant) {
		let notes = fetchNotes(for: plant) ?? []
		let events = fetchEvents(for: plant) ?? []

		let notesAndEventsAsPosts = notes.map { PlantPost(type: .note($0)) } + events.map { PlantPost(type: .event($0)) }
	
		posts = notesAndEventsAsPosts.sorted { $0.timestamp > $1.timestamp }
	}
	
//	MARK: - Plant functions
	
	func fetchPlantStage(for plant: Plant) {
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		plantStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
	}
	
	func fetchPlantType(for plant: Plant) {
		let savedPlantType = PlantType(rawValue: plant.wrappedType)!
		plantType = savedPlantType
		selectedTypeIndex = PlantType.allCases.firstIndex(of: savedPlantType)!
	}
	
	func updatePlantStage(for plant: Plant) {
		manager.addStageUpdate(plant: plant, newStage: plantStage.rawValue)
		fetchPosts(for: plant)
	}
	
	func resetStageUpdatedFlag() {
		plantStageUpdated = false
		showingAddPostOptions = false
	}
	
	func fetchPlantGeneralDetails(for plant: Plant) {
		plantNameInput = plant.wrappedName
		plantVarietyInput = plant.wrappedVariety
		fetchPlantStage(for: plant)
		fetchPlantType(for: plant)
	}
	
	func editPlantGeneralDetails(for plant: Plant) {
		manager.editPlantGeneralDetails(
			for: plant,
			name: plantNameInput,
			variety: plantVarietyInput,
			type: plantType.rawValue,
			stage: plantStage.rawValue)
	}
	
	func resetPlantGeneralDetailsEditedFlag() {
		plantNameInput = ""
		plantGeneralDetailsEdited = false
	}
	
	func fetchPlantCareRequirements(for plant: Plant) {
		sunlightRequirementInput = plant.wrappedSunlightRequirement
		temperatureRequirementInput = plant.wrappedTemperatureRequirement
		waterRequirementInput = plant.wrappedWaterRequirement
		humidityRequirementInput = plant.wrappedHumidityRequirement
		soilRequirementInput = plant.wrappedSoilRequirement
		fertilizerRequirementInput = plant.wrappedFertilizerRequirement
	}
	
	func editPlantCareRequirements(for plant: Plant) {
		manager.editPlantCareRequirements(
			for: plant,
			sunlightRequirement: sunlightRequirementInput,
			temperatureRequirement: temperatureRequirementInput,
			waterRequirement: waterRequirementInput,
			humidityRequirement: humidityRequirementInput,
			soilRequirement: soilRequirementInput,
			fertilizerRequirement: fertilizerRequirementInput
		)
	}
	
	func resetPlantCareRequirementsEditedFlag() {
		plantCareRequirementsEdited = false
	}
	
	func fetchPlantAdditionalCareNotes(for plant: Plant) {
		additionalCareNotesInput = plant.wrappedAdditionalCareNotes
	}
	
	func editPlantAdditionalCareNotes(for plant: Plant) {
		manager.editAdditionalCareNotes(
			for: plant,
			additionalCareNotes: additionalCareNotesInput
		)
	}
	func resetPlantAdditionalCareNotesEditedFlag() {
		plantAdditionalCareNotesEdited = false
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
