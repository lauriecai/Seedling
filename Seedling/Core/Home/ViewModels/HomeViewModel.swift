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
	
	private func fetchPlants() {
		let request = manager.requestAllPlants()
		
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func deletePlant(plant: Plant) {
		if let savedPlant = plants.first(where: { $0.id == plant.id }) {
			manager.deletePlant(plant: savedPlant)
		}
	}
	
	func resetOffsets() {
		for plant in plants {
			resetOffsets()
		}
	}
}
