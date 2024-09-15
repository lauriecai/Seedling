//
//  DetailViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import CoreData
import Foundation

class DetailViewModel: ObservableObject {
	
	let coreDataManager = CoreDataManager.shared
	let fileManager = FileManager()
	
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
		PerformanceManager.shared.startTrace(name: "detail_vm_fetch_posts")
		
		let notes = fetchNotes(for: plant) ?? []
		PerformanceManager.shared.setValue(name: "detail_vm_fetch_posts", value: notes.count, metric: "number_of_notes")
		
		let events = fetchEvents(for: plant) ?? []
		PerformanceManager.shared.setValue(name: "detail_vm_fetch_posts", value: events.count, metric: "number_of_events")
		
		let photos = photoService.fetchPhotos(for: plant) ?? []
		PerformanceManager.shared.setValue(name: "detail_vm_fetch_posts", value: photos.count, metric: "number_of_photos")

		let posts = notes.map { PlantPost(type: .note($0)) } + 
					events.map { PlantPost(type: .event($0)) } +
					photos.map { PlantPost(type: .photo($0)) }
	
		PerformanceManager.shared.setValue(name: "detail_vm_fetch_posts", value: posts.count, metric: "number_of_posts")
		
		self.posts = posts.sorted { $0.timestamp > $1.timestamp }
		PerformanceManager.shared.stopTrace(name: "detail_vm_fetch_posts")
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
		coreDataManager.addStageUpdate(plant: plant, newStage: selectedStage.rawValue)
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
		coreDataManager.editPlantGeneralDetails(
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
		coreDataManager.editPlantCareRequirements(
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
		coreDataManager.editAdditionalCareNotes(
			for: plant,
			additionalCareNotes: additionalCareNotesInput
		)
	}
	func resetPlantAdditionalCareNotesEditedFlag() {
		plantAdditionalCareNotesEdited = false
	}
	
//	MARK: - Note functions
	
	private func fetchNotes(for plant: Plant) -> [Note]? {
		let request = coreDataManager.requestNotes(for: plant)
		
		do {
			return try coreDataManager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
			return nil
		}
	}
	
	func addNote(for plant: Plant, title: String, body: String) {
		coreDataManager.addNote(for: plant, title: title, body: body)
		fetchPosts(for: plant)
	}
	
	func deleteNote(note: Note) {
		coreDataManager.deleteNote(note: note)
		fetchPosts(for: plant)
	}
	
	func updateNoteTitleAndBody(for note: Note, title: String, body: String) {
		coreDataManager.updateNoteTitleAndBody(for: note, title: title, body: body)
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
		let request = coreDataManager.requestEvents(for: plant)
		
		do {
			return try coreDataManager.context.fetch(request)
		} catch let error {
			print("Error fetching events from Core Data. \(error)")
			return nil
		}
	}
	
	func deleteEvent(event: Event) {
		coreDataManager.deleteEvent(event: event)
		fetchPosts(for: plant)
	}
	
//  MARK: - Photo functions
	
	func deletePhoto() {
		guard let imageUrlString = selectedPhoto?.imageUrlString,
			  let savedPhoto = findExistingPhoto(for: plant) else { return }
		
		fileManager.deleteImage(id: imageUrlString)
		coreDataManager.deletePhoto(photo: savedPhoto)
		fetchPosts(for: plant)
	}
	
	private func findExistingPhoto(for plant: Plant) -> Photo? {
		guard let selectedPhoto = selectedPhoto else { return nil }
		
		let allPhotos = fetchPhotos(for: plant)
		
		if let existingPhoto = allPhotos?.first(where: { $0.imageUrlString == selectedPhoto.imageUrlString })
		{ return existingPhoto } else { return nil }
	}
	
	private func fetchPhotos(for plant: Plant) -> [Photo]? {
		photoService.fetchPhotos(for: plant)
	}
	
//  MARK: - UI functions
	
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

	
