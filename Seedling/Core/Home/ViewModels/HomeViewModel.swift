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
	
	init() {
		fetchPlants()
	}
	
//	MARK: Data functions
	
	/// Saves contextual working changes to Core Data, then refreshes the plants array
	func save() {
		manager.save()
		fetchPlants()
	}
	
//	MARK: Plant variables
	
	/// Returns an array of plant names
	var plantNames: [String] {
		var names: [String] = []
		for plant in plants { names.append(plant.wrappedFullNameLabel) }
		
		return names
	}
	
//	MARK: Plant functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date data from Core Data
	func fetchPlants() {
		let request = manager.requestPlants()
		
		do {
			self.plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	/// Creates a new plant and saves to Core Data, then refreshes the plants array
	func addPlant(type: String, name: String, variety: String, stage: String) {
		manager.addPlant(type: type, name: name, variety: variety, stage: stage)
		fetchPlants()
	}
	
	/// Deletes a plant from Core Data, then refreshes the plants array
	func deletePlant(plant: Plant) {
		manager.deletePlant(plant: plant)
		fetchPlants()
	}
	
	/// Resets plant card offsets, then refreshes the plants array
	func resetOffsets() {
		for plant in plants {
			manager.resetOffsets(plant: plant)
		}
		fetchPlants()
	}
}
