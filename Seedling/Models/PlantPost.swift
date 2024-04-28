//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost: Identifiable, Hashable {
	
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
	
	func hash(into hasher: inout Hasher) {
		switch type {
		case .event(let event):
			hasher.combine(event.title)
			hasher.combine(event.wrappedTimestamp)
		case .note(let note):
			hasher.combine(note.wrappedTitle)
			hasher.combine(note.wrappedBody)
		}
	}
	
	static func == (lhs: PlantPost, rhs: PlantPost) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

enum CoreDataEntityType {
	case event(Event)
	case note(Note)
}
