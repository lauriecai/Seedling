//
//  DetailView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import SwiftUI

struct DetailLoadingView: View {
	
	@Binding var plant: Plant?
	
	var body: some View {
		ZStack {
			if let plant = plant {
				DetailView(plant: plant)
			}
		}
	}
}

struct DetailView: View {
	
	@StateObject private var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State private var showActionSheet: Bool = false
	@State private var selectedNote: Note? = nil
	
	@State private var showingAddNoteLoadingView: Bool = false
	
	init(plant: Plant) {
		print("-----\nInitializing DetailView for \(plant.wrappedName)...")
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
		print("DetailView initialized for \(plant.wrappedName)!")
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			VStack {
				Text(viewModel.plant.wrappedStage)
				notesList
			}
			addNoteButton
				.padding(.trailing, 20)
		}
		.navigationTitle(viewModel.plant.wrappedFullNameLabel)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.onAppear {
			viewModel.fetchNotes(for: viewModel.plant)
		}
		.actionSheet(isPresented: $showActionSheet) {
			ActionSheet(
				title: Text("Note options"),
				buttons: [
					.destructive(Text("Delete note")) {
						if let selectedNote = selectedNote {
							withAnimation(Animation.easeInOut(duration: 0.4)) {
								viewModel.deleteNote(note: selectedNote)
								viewModel.fetchNotes(for: viewModel.plant)
							}
						}
					},
					.cancel()
				]
			)
		}
		.navigationDestination(isPresented: $showingAddNoteLoadingView) {
			if showingAddNoteLoadingView {
				AddNoteLoadingView(viewModel: viewModel)
			}
		}
    }
}

// MARK: - UI

extension DetailView {
	
	private var notesList: some View {
		ScrollView {
			ForEach(viewModel.notes) { note in
				NoteCardView(note: note, showPlantTag: false, showActionSheet: $showActionSheet, showActionForNote: $selectedNote)
			}
		}
		.frame(maxWidth: .infinity)
	}
	
	private var addNoteButton: some View {
		ButtonCircle(icon: "icon-plus")
			.onTapGesture { showingAddNoteLoadingView.toggle() }
	}
	
	private var backButton: some View {
		Button {
			dismiss()
		} label: {
			HStack(spacing: 5) {
				Image(systemName: "chevron.left")
					.font(.handjet(.medium, size: 18))
				Text("Back")
					.font(.handjet(.medium, size: 20))
			}
			.foregroundStyle(Color.theme.textSecondary)
		}
	}
}
