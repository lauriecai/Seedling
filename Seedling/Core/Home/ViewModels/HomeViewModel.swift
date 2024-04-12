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
	
	@Published var plants: [Plant] = []
	
	@Published var selectedPlant: Plant? = nil
	@Published var showingDetailView: Bool = false
	@Published var showingAddPlantView: Bool = false
	
	@Published var showActionSheet: Bool = false
	
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
		fetchPlants()
	}
	
	func deletePlant(plant: Plant) {
		manager.deletePlant(plant: plant)
		fetchPlants()
	}
}
