//
//  JournalView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import SwiftUI

struct JournalView: View {
	
	@StateObject private var viewModel = JournalViewModel()
	
	@State private var showActionSheet: Bool = false
	@State private var selectedNote: Note? = nil
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			notesList
			
			if !viewModel.plants.isEmpty {
				addNoteButton
					.padding(.trailing, 20)
					.padding(.bottom, 25)
			}
		}
		.onAppear {
			viewModel.fetchNotes()
		}
		.actionSheet(isPresented: $showActionSheet) {
			ActionSheet(
				title: Text("Note options"),
				buttons: [
					.destructive(Text("Delete note")) {
						if let selectedNote = selectedNote {
							withAnimation(Animation.easeInOut(duration: 0.4)) {
								viewModel.deleteNote(note: selectedNote)
							}
						}
					},
					.cancel()
				]
			)
		}
    }
}

#Preview {
    JournalView()
}

extension JournalView {
	
	private var notesList: some View {
		ScrollView {
			VStack(spacing: 10) {
				ForEach(viewModel.notes) { note in
					NoteCardView(note: note, showPlantTag: true, showActionSheet: $showActionSheet, showActionsForNote: $selectedNote)
				}
			}
			.padding(.bottom, 50)
		}
	}
	
	private var addNoteButton: some View {
		NavigationLink(destination: AddGeneralNoteView(viewModel: viewModel)) {
			ButtonCircle(icon: "icon-plus")
		}
	}
}
