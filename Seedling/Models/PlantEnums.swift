//
//  PlantEnums.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import Foundation

enum PlantStage: String, CaseIterable, RawRepresentable {
	case seed = "Seed"
	case germination = "Germination"
	case seedling = "Seedling"
	case bulb = "Bulb"
	case transplant = "Transplant"
	case vegetativeGrowth = "Vegetative Growth"
	case flowering = "Flowering"
	case pollination = "Pollination"
	case fruitFormation = "Fruit Formation"
	case vegetableFormation = "Vegetable Formation"
	case harvested = "Harvested"
	
	var definition: String {
		switch self {
		case .seed: "A small object from which a new plant can grow."
		case .germination: "The emergence of a tiny root and shoot."
		case .seedling: "A young plant with its first set of leaves."
		case .bulb: "An underground bulb from which a new plant can grow."
		case .transplant: "The process of moving a plant to a new environment."
		case .vegetativeGrowth: "The growth of leaves, stems, and roots establishing the plant."
		case .flowering: "A stage where the plant produces flowers."
		case .pollination: "A period of pollen transfer leading to plant fertilization."
		case .fruitFormation: "The development of edible fruits."
		case .vegetableFormation: "The development of edible greens."
		case .harvested: "The act of gathering mature plants."
		}
	}
	
	var update: String {
		switch self {
		case .seed: ""
		case .germination: "germinated."
		case .seedling: "has become a seedling."
		case .bulb: ""
		case .transplant: "has been transplanted."
		case .vegetativeGrowth: "has started developing leaves."
		case .flowering: "has begun flowering."
		case .pollination: "is undergoing pollination."
		case .fruitFormation: "is developing fruit."
		case .vegetableFormation: "is developing edible greens."
		case .harvested: "has been harvested!"
		}
	}
}

enum PlantType: String, CaseIterable {
	case vegetable = "Vegetable"
	case fruit = "Fruit"
	case herb = "Herb"
	case flower = "Flower"
	case shrub = "Shrub"
	case succulent = "Succulent"
}
