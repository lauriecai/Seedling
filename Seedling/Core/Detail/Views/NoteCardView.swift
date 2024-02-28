//
//  NoteCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/18/24.
//

import SwiftUI

struct NoteCardView: View {
	
	let note: Note
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack {
				Text(note.wrappedTimestamp.asDateAndTime())
					.font(.handjet(.regular, size: 18))
					.foregroundStyle(Color.theme.textSecondary)
				
				Spacer()
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
