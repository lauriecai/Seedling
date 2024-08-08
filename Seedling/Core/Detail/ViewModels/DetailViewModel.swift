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
	@Published var noteTitleInput: String = ""
	@Published var noteBodyInput: String = ""
	
	@Published var editingExistingNote: Bool = false
	@Published var noteEdited: Bool = false
	
	// Update Stage View
	@Published var selectedStage: PlantStage
	@Published var selectedStageIndex: Int
	@Published var plantStageUpdated: Bool = false
	
	// Plant Details View
	@Published var plantNameInput: String = ""
	@Published var plantVarietyInput: String = ""
	
	@Published var selectedType: PlantType
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
	@Published var showingAddNoteView: Bool = false
	@Published var showingAddPhotoView: Bool = false
	@Published var showingUpdateStageView: Bool = false
	@Published var showingPlantDetailsView: Bool = false
	
	// Add Post View Segues
	@Published var showNoteActionSheet: Bool = false
	@Published var selectedNote: Note? = nil
	
	@Published var showEventActionSheet: Bool = false
	@Published var selectedEvent: Event? = nil
	
	@Published var showPhotoActionSheet: Bool = false
	@Published var selectedPhoto: Photo? = nil
	
	// Plant Details Segues
	@Published var editingGeneralDetails: Bool = false
	@Published var editingCareRequirements: Bool = false
	@Published var editingAdditionalCareNotes: Bool = false
	
	// PhotosPicker Segues
	@Published var showingPhotosPicker: Bool = false
	
	// Services
	private let photoService = PhotoService()
	
	init(plant: Plant) {
		self.plant = plant
		
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		selectedStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
		
		let savedPlantType = PlantType(rawValue: plant.wrappedType)!
		selectedType = savedPlantType
		selectedTypeIndex = PlantType.allCases.firstIndex(of: savedPlantType)!
		
		fetchPlantGeneralDetails(for: plant)
	}
	
//	MARK: - Post functions
	
	func fetchPosts(for plant: Plant) {
		let notes = fetchNotes(for: plant) ?? []
		let events = fetchEvents(for: plant) ?? []
		let photos = photoService.fetchPhotos(for: plant) ?? []

		let posts = notes.map { PlantPost(type: .note($0)) } + 
					events.map { PlantPost(type: .event($0)) } +
					photos.map { PlantPost(type: .photo($0)) }
	
		self.posts = posts.sorted { $0.timestamp > $1.timestamp }
	}
	
//	MARK: - Plant functions
	
	func fetchPlantStage(for plant: Plant) {
		let savedPlantStage = PlantStage(rawValue: plant.wrappedStage)!
		selectedStage = savedPlantStage
		selectedStageIndex = PlantStage.allCases.firstIndex(of: savedPlantStage)!
	}
	
	func fetchPlantType(for plant: Plant) {
		let savedPlantType = PlantType(rawValue: plant.wrappedType)!
		selectedType = savedPlantType
		selectedTypeIndex = PlantType.allCases.firstIndex(of: savedPlantType)!
	}
	
	func updatePlantStage(for plant: Plant) {
		manager.addStageUpdate(plant: plant, newStage: selectedStage.rawValue)
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
			type: selectedType.rawValue,
			stage: selectedStage.rawValue)
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
		noteTitleInput = note.wrappedTitle
		noteBodyInput = note.wrappedBody
	}
	
	func resetAddNoteFormInputs() {
		resetTitleAndBodyTextFields()
		editingExistingNote = false
	}
	
	func resetNoteEditedFlag() {
		noteEdited = false
	}
	
	private func resetTitleAndBodyTextFields() {
		noteTitleInput = ""
		noteBodyInput = ""
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
	
// MARK: - UI functions
	
	func activateTextFieldEditModeForAll() {
		if !sunlightRequirementInput.isEmpty {
			sunlightRequirementInput = activateTextFieldEditMode(plantProperty: sunlightRequirementInput)
		}
		
		if !temperatureRequirementInput.isEmpty {
			temperatureRequirementInput = activateTextFieldEditMode(plantProperty: temperatureRequirementInput)
		}
		
		if !waterRequirementInput.isEmpty {
			waterRequirementInput = activateTextFieldEditMode(plantProperty: waterRequirementInput)
		}
		
		if !humidityRequirementInput.isEmpty {
			humidityRequirementInput = activateTextFieldEditMode(plantProperty: humidityRequirementInput)
		}
		
		if !soilRequirementInput.isEmpty {
			soilRequirementInput = activateTextFieldEditMode(plantProperty: soilRequirementInput)
		}
		
		if !fertilizerRequirementInput.isEmpty {
			fertilizerRequirementInput = activateTextFieldEditMode(plantProperty: fertilizerRequirementInput)
		}
	}
	
	func removeExtraneousSpaceForAll() {
		sunlightRequirementInput = removeExtraneousSpace(plantProperty: sunlightRequirementInput)
		
		temperatureRequirementInput = removeExtraneousSpace(plantProperty: temperatureRequirementInput)
		
		waterRequirementInput = removeExtraneousSpace(plantProperty: waterRequirementInput)
		
		humidityRequirementInput = removeExtraneousSpace(plantProperty: humidityRequirementInput)
		
		soilRequirementInput = removeExtraneousSpace(plantProperty: soilRequirementInput)
		
		fertilizerRequirementInput = removeExtraneousSpace(plantProperty: fertilizerRequirementInput)
	}
	
	func activateTextFieldEditMode(plantProperty: String) -> String {
		return plantProperty + " "
	}
	
	func removeExtraneousSpace(plantProperty: String) -> String {
		return plantProperty.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
	}
}

	
