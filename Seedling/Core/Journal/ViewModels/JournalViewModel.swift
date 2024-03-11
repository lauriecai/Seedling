//
//  JournalViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import CoreData
import Foundation

class JournalViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	@Published var allNotes: [Note] = []
	
	init() {
		fetchAllNotes()
	}
	
	private func fetchAllNotes() {
		let request = manager.requestAllNotes()
		
		do {
			allNotes = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching notes from Core Data. \(error)")
		}
	}
}
