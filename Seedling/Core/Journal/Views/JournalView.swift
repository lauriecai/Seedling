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
				.padding(.horizontal)
			
			if !viewModel.allPlants.isEmpty {
				addNoteButton
					.padding(.trailing, 20)
					.padding(.bottom, 25)
			}
		}
		.onAppear {
			viewModel.fetchAllNotes()
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
				NoteCardView(note: note)
			}
		}
	}
	
	private var addNoteButton: some View {
		NavigationLink(destination: AddGeneralNoteView(selectedPlant: viewModel.allPlants.first!)) {
		ButtonCircle(icon: "icon-plus")
		}
	}
}
