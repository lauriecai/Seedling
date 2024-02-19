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
					.font(.handjet(.regular, size: 16))
					.foregroundStyle(Color.theme.textPrimary.opacity(0.50))
				
				Spacer()
			}
			
			Text(note.wrappedTitle)
				.font(.handjet(.bold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
			
			Text(note.wrappedBody)
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textPrimary)
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
