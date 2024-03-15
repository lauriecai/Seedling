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
	
	@Binding var showActionSheet: Bool
	@Binding var showActionForNote: Note?
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack {
				if showPlantTag { plantTag }
				Spacer()
				noteActions
			}
			
			if !note.wrappedTitle.isEmpty { titleText }
			
			bodyText
			
			timestamp
		}
		.padding()
		.background(Color.theme.backgroundLight)
    }
}

extension NoteCardView {
	
	private var plantTag: some View {
		Text(note.plant?.wrappedFullNameLabel ?? "")
			.font(.handjet(.bold, size: 18))
			.foregroundStyle(Color.theme.textPrimary)
			.padding(.horizontal, 8)
			.padding(.vertical, 2)
			.background(Color.theme.backgroundAccent)
			.clipShape(RoundedRectangle(cornerRadius: 4))
	}
	
	private var noteActions: some View {
		Button {
			showActionSheet = true
			showActionForNote = note
		} label: {
			Image(systemName: "ellipsis")
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var titleText: some View {
		Text(note.wrappedTitle)
			.font(.handjet(.bold, size: 24))
			.foregroundStyle(Color.theme.textPrimary)
	}
	
	private var bodyText: some View {
		Text(note.wrappedBody)
			.font(.handjet(.medium, size: 20))
			.foregroundStyle(Color.theme.textPrimary)
	}
	
	private var timestamp: some View {
		HStack {
			Text(note.wrappedTimestamp.asDateAndTime())
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
			
			Spacer()
		}
	}
}
