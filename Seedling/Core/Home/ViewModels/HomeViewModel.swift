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
	@Published var plantName: String = ""
	@Published var plantVariety: String = ""
	
	@Published var plantStage: PlantStage = .seed
	@Published var selectedStageIndex: Int = 0
	
	@Published var plantType: PlantType = .vegetable
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
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
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
		plantName = plant.wrappedName
		plantVariety = plant.wrappedVariety
	}
	
	func resetAddPlantFormInputsAndFlags() {
		resetNameAndVarietyTextFields()
		editingExistingPlant = false
	}
	
	func resetPlantDetailsChangedFlag() {
		plantDetailsEdited = false
	}
	
	private func resetNameAndVarietyTextFields() {
		plantName = ""
		plantVariety = ""
	}
}
