//
//  HomeViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 2/1/24.
//

import CoreData
import Foundation

class HomeViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	// Home View
	@Published var plants: [Plant] = []
	
	// Add Plant View
	@Published var plantNameInput: String = ""
	@Published var plantVarietyInput: String = ""
	
	@Published var selectedStage: PlantStage = .seed
	@Published var selectedStageIndex: Int = 0
	
	@Published var selectedType: PlantType = .vegetable
	@Published var selectedTypeIndex: Int = 0
	
	@Published var editingExistingPlant: Bool = false
	@Published var plantDetailsEdited: Bool = false
	
	// Segues
	@Published var showingDetailView: Bool = false
	@Published var showingAddPlantView: Bool = false
	
	@Published var selectedPlant: Plant? = nil
	@Published var showingActionSheet: Bool = false
	
//	MARK: - Plant functions
	
	func fetchPlants() {
		PerformanceManager.shared.startTrace(name: "home_vm_fetch_plants_duration")
		let request = manager.requestPlants()
		
		defer {
			PerformanceManager.shared.stopTrace(name: "home_vm_fetch_plants_duration")
		}
		
		do {
			plants = try manager.context.fetch(request)
			PerformanceManager.shared.setValue(name: "home_vm_fetch_plants_duration", value: plants.count, metric: "number_of_plants")
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func addPlant(name: String, variety: String, stage: String, type: String) {
		manager.addPlant(name: name, variety: variety, stage: stage, type: type)
		resetAddPlantFormInputsAndFlags()
		fetchPlants()
	}
	
	func deletePlant(plant: Plant) {
		manager.deletePlant(plant: plant)
		fetchPlants()
	}
	
	func updatePlantNameAndVariety(for plant: Plant, name: String, variety: String) {
		manager.updatePlantNameAndVariety(for: plant, name: name, variety: variety)
		fetchPlants()
	}
	
	func fetchExistingPlantNameAndVariety(for plant: Plant) {
		plantNameInput = plant.wrappedName
		plantVarietyInput = plant.wrappedVariety
	}
	
	func resetAddPlantFormInputsAndFlags() {
		resetNameAndVarietyTextFields()
		editingExistingPlant = false
		selectedStage = .seed
		selectedStageIndex = 0
		
		selectedType = .vegetable
		selectedTypeIndex = 0
	}
	
	func resetPlantDetailsChangedFlag() {
		plantDetailsEdited = false
	}
	
	private func resetNameAndVarietyTextFields() {
		plantNameInput = ""
		plantVarietyInput = ""
	}
}
