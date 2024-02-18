//
//  AddNoteView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/18/24.
//

import SwiftUI

struct AddNoteView: View {
	
	let plant: Plant
	
    var body: some View {
		Text("Add a new note for \(plant.wrappedFullName)")
    }
}
