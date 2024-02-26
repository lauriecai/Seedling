//
//  PlantEnums.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import Foundation

enum PlantStage: String, CaseIterable {
	case seed = "Seed"
	case seedling = "Seedling"
	case bulb = "Bulb"
	case transplant = "Transplant"
}

enum PlantType: String, CaseIterable {
	case vegetable = "Vegetable"
	case fruit = "Fruit"
	case herb = "Herb"
	case flower = "Flower"
	case shrub = "Shrub"
}
