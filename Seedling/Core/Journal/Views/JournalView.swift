//
//  JournalView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import SwiftUI

struct JournalView: View {
	
	@StateObject private var viewModel = JournalViewModel()
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			notesList
			ButtonCircle(icon: "icon-plus")
				.padding(.trailing, 20)
		}
    }
}

#Preview {
    JournalView()
}

extension JournalView {
	
	private var notesList: some View {
		ScrollView {
			ForEach(viewModel.allNotes) { note in
				NoteCardView(note: note, showPlantTag: true)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.horizontal)
	}
	
//	private var addNoteButton: some View {
//		NavigationLink(destination: AddNoteView(viewModel: viewModel)) {
//			ButtonCircle(icon: "icon-plus")
//		}
//	}
}
