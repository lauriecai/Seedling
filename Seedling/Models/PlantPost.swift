//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost: Identifiable {
	let type: CoreDataEntityType
	
	var id: UUID {
		switch type {
		case .event(let event):
			event.wrappedId
		case .note(let note):
			note.wrappedId
		}
	}
	
	var timestamp: Date {
		switch type {
		case .event(let event):
			event.wrappedTimestamp
		case .note(let note):
			note.wrappedTimestamp
		}
	}
}

enum CoreDataEntityType {
	case event(Event)
	case note(Note)
}
