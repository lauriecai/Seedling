//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost: Identifiable {
	let timestamp: Date
	let entity: EntityType
	var id: Date { timestamp }
	
}

enum EntityType {
	case event(Event)
	case note(Note)
}
