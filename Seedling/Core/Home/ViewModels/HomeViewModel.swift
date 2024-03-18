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
	
	var plantNames: [String] {
		var names: [String] = []
		for plant in plants {
			names.append(plant.wrappedFullNameLabel)
		}
		
		return names
	}
	
	func addPlant(type: String, name: String, variety: String, stage: String) {
		manager.addPlant(type: type, name: name, variety: variety, stage: stage)
		fetchPlants()
	}
	
	func fetchPlants() {
		let request = manager.requestPlants()
		
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func deletePlant(plant: Plant) {
		if let savedPlant = plants.first(where: { $0.id == plant.id }) {
			manager.deletePlant(plant: savedPlant)
			fetchPlants()
		}
	}
	
	func save() {
		manager.save()
		fetchPlants()
	}
	
	func resetOffsets() {
		for plant in plants {
			manager.resetOffsets(plant: plant)
		}
		fetchPlants()
	}
}
