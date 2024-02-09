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
		let request = NSFetchRequest<Plant>(entityName: "Plant")
		do {
			plants = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching plants from Core Data. \(error)")
		}
	}
	
	func addPlant(type: String, name: String, variety: String, stage: String) {
		let newPlant = Plant(context: manager.context)
		newPlant.id = UUID()
		newPlant.type = type
		newPlant.name = name
		newPlant.variety = variety
		newPlant.stage = stage
		newPlant.offset = 0
		
		save()
	}
	
	func save() {
		manager.save()
		fetchPlants() // refreshes plants array with most recently saved data
	}
	
	func deletePlant(plant: Plant) {
		if let savedPlant = plants.first(where: { $0.id == plant.id }) {
			manager.context.delete(savedPlant)
			save()
		}
	}
	
	func resetOffsets() {
		for plant in plants {
			plant.offset = 0
		}
		save()
	}
}
