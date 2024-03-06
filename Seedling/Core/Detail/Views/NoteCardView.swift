//
//  NoteCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/18/24.
//

import SwiftUI

struct NoteCardView: View {
	
	let note: Note
	let showPlantTag: Bool
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			if showPlantTag {
				HStack {
					if let plant = note.plant {
						Tag(text: plant.wrappedFullNameLabel)
					}
					
					Spacer()
				}
			}
			
			if !note.wrappedTitle.isEmpty {
				Text(note.wrappedTitle)
					.font(.handjet(.bold, size: 24))
					.foregroundStyle(Color.theme.textPrimary)
			}
			
			Text(note.wrappedBody)
				.font(.handjet(.medium, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
		}
		.padding()
		.background(Color.theme.backgroundLight)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
