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
	
//	MARK: - Plant functions
//	Data needs to be refetched every time a change has been saved to Core Data
	
	/// Fetches the most up-to-date plants from Core Data
	func fetchPlants() {
		print("-----\nIn HomeViewModel fetchPlants()")
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
			print("HomeViewModel fetchPlants() complete!")
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
}
