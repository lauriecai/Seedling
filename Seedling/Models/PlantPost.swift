//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost {
	let entity: EntityType
	let timestamp: Date
}

enum EntityType {
	case event(Event)
	case note(Note)
}
