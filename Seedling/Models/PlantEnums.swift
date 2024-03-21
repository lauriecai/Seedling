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
		case .germination: "The process by which a seed transforms into a young plant, marked by the emergence of a root and shoot."
		case .seedling: "A young plant that has recently sprouted from seed, characterized by the emergence of its first set of leaves and roots."
		case .bulb: "A short, underground structure of a plant consisting of a modified shoot."
		case .transplant: "The process of moving a growing plant from one location to another, allowing its development in a new environment."
		case .vegetativeGrowth: "A phase in a plant's life cycle where it focuses on developing stems, leaves, and roots, contributing to overall plant size and structure."
		case .flowering: "A stage in a plant's life cycle where it produces flowers, marking the transition to the reproductive phase with the potential for seed or fruit formation."
		case .pollination: "The process by which pollen from the male reproductive organs of a flower (anther) is transferred to the female reproductive organs (stigma), facilitating fertilization and the production of seeds."
		case .fruitFormation: "The process in which the fertilized ovary of a flower develops into a mature fruit, enclosing and protecting seeds that have the potential to grow into new plants."
		case .vegetableFormation: "The development of edible plant parts such as roots, leaves, stems, or flowers, derived from the vegetative structures of a plant"
		case .harvested: "The act of gathering and collecting mature crops or plants."
		}
	}
}

enum PlantType: String, CaseIterable {
	case vegetable = "Vegetable"
	case fruit = "Fruit"
	case herb = "Herb"
	case flower = "Flower"
	case shrub = "Shrub"
}
