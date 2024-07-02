//
//  DetailViewPosts.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import Foundation

struct PlantPost: Hashable {
	
	let type: CoreDataEntityType
	
	var timestamp: Date {
		switch type {
		case .event(let event):
			event.wrappedTimestamp
		case .note(let note):
			note.wrappedTimestamp
		case .photo(let photo):
			photo.wrappedTimestamp
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
			hasher.combine(note.wrappedTimestamp)
		
		case .photo(let photo):
			hasher.combine(photo.wrappedCaption)
			hasher.combine(photo.wrappedTimestamp)
		}
	}
	
	static func == (lhs: PlantPost, rhs: PlantPost) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

enum CoreDataEntityType {
	case event(Event)
	case note(Note)
	case photo(Photo)
}
