//
//  DetailViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import CoreData
import Foundation

class DetailViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	@Published var plant: Plant
	
	init(plant: Plant) {
		self.plant = plant
	}
}
