//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost: Identifiable {
	let entity: EntityType
	
	var id: UUID {
		switch entity {
		case .event(let event):
			event.wrappedId
		case .note(let note):
			note.wrappedId
		}
	}
	
	var timestamp: Date {
		switch entity {
		case .event(let event):
			event.wrappedTimestamp
		case .note(let note):
			note.wrappedTimestamp
		}
	}
}

enum EntityType {
	case event(Event)
	case note(Note)
}
