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
	
	// Segues
	@Published var showingDetailView: Bool = false
	@Published var showingAddPlantView: Bool = false
	
	@Published var selectedPlant: Plant? = nil
	@Published var showActionSheet: Bool = false
	
	// Add Plant View
	@Published var plantName: String = ""
	@Published var plantVariety: String = ""
	
	@Published var plantStage: PlantStage = .seed
	@Published var selectedStageIndex: Int = 0
	
	@Published var plantType: PlantType = .vegetable
	@Published var selectedTypeIndex: Int = 0
	
//	MARK: - Plant functions
	
	func fetchPlants() {
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func addPlant(type: String, name: String, variety: String, stage: String) {
		manager.addPlant(type: type, name: name, variety: variety, stage: stage)
		resetAddPlantFormInputs()
		fetchPlants()
	}
	
	func deletePlant(plant: Plant) {
		manager.deletePlant(plant: plant)
		fetchPlants()
	}
	
	func resetAddPlantFormInputs() {
		resetNameAndVarietyTextFields()
		resetPlantStageSelectionRow()
		resetPlantTypeSelectionRow()
	}
	
	private func resetNameAndVarietyTextFields() {
		plantName = ""
		plantVariety = ""
	}
	
	private func resetPlantStageSelectionRow() {
		plantStage = .seed
		selectedStageIndex = 0
	}
	
	private func resetPlantTypeSelectionRow() {
		plantType = .vegetable
		selectedTypeIndex = 0
	}
}
