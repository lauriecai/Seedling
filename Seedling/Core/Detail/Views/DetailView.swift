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
	
//	@State private var showingAddPostOptions: Bool = false
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			postsList

			if viewModel.showingAddPostOptions { darkOverlay }
			
			addPostActionGroup
		}
		.navigationTitle(viewModel.plant.wrappedFullNameLabel)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.onAppear {
			viewModel.fetchPosts(for: viewModel.plant)
			viewModel.showingAddPostOptions = false
		}
		.navigationDestination(isPresented: $viewModel.showAddNoteLoadingView) {
			if viewModel.showAddNoteLoadingView {
				AddNoteLoadingView(viewModel: viewModel)
			}
		}
		.sheet(isPresented: $viewModel.showUpdateStageLoadingView) {
			if viewModel.showUpdateStageLoadingView {
				UpdateStageLoadingView(viewModel: viewModel)
			}
		}
		
    }
}

// MARK: - UI

extension DetailView {
	
	private var postsList: some View {
		ScrollView {
			ForEach(viewModel.posts, id: \.self.hashValue) { post in
				switch post.type {
				case .event(let event):
					eventCard(for: event)
						.confirmationDialog("Stage Update Options", isPresented: $viewModel.showEventActionSheet) {
							editEventButton
							deleteEventButton
						} message: {
							Text("What do you want to do with this stage update?")
						}
				case .note(let note):
					noteCard(for: note)
						.confirmationDialog("Note Options", isPresented: $viewModel.showNoteActionSheet) {
							editNoteButton
							deleteNoteButton
						} message: {
							Text("What do you want to do with this note?")
						}
				}
			}
			.padding(.horizontal)
		}
	}
	
	private func eventCard(for event: Event) -> EventCardView {
		EventCardView(event: event, showActionSheet: $viewModel.showEventActionSheet, showActionsForEvent: $viewModel.selectedEvent)
	}
	
	private var editEventButton: some View {
		Button("Edit Stage Update") {
			print("Add note view edit event triggered!")
		}
	}
	
	private var deleteEventButton: some View {
		Button("Delete Stage Update", role: .destructive) {
			if let selectedEvent = viewModel.selectedEvent {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
					viewModel.deleteEvent(event: selectedEvent)
				}
			}
		}
	}
	
	private func noteCard(for note: Note) -> NoteCardView {
		NoteCardView(note: note, showPlantTag: false, showActionSheet: $viewModel.showNoteActionSheet, showActionsForNote: $viewModel.selectedNote)
	}
	
	private var editNoteButton: some View {
		Button("Edit note") {
			viewModel.resetNoteEditedFlag()
			
			if let selectedNote = viewModel.selectedNote {
				viewModel.editingExistingNote = true
				viewModel.showAddNoteLoadingView = true
				viewModel.fetchExistingNoteTitleAndBody(for: selectedNote)
			}
		}
	}
	
	private var deleteNoteButton: some View {
		Button("Delete note", role: .destructive) {
			if let selectedNote = viewModel.selectedNote {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
					viewModel.deleteNote(note: selectedNote)
				}
			}
		}
	}
	
	private var addPostActionGroup: some View {
		VStack(alignment: .trailing, spacing: 20) {
			if viewModel.showingAddPostOptions {
				addPostOptionsButtons
			}
			
			addPostButton
		}
		.padding(.horizontal, 20)
		.padding(.bottom, 20)
	}
	
	private var addPostOptionsButtons: some View {
		VStack(alignment: .trailing, spacing: 12) {
			addNoteButton
			addPhotoButton
			updateStageButton
		}
	}
	
	private var addNoteButton: some View {
		ButtonRounded(iconName: "pencil", text: "Add Note")
			.onTapGesture { viewModel.showAddNoteLoadingView.toggle() }
	}
	
	private var addPhotoButton: some View {
		ButtonRounded(iconName: "photo.fill", text: "Add Photo")
			.onTapGesture { print("Add photo tapped!") }
	}
	
	private var updateStageButton: some View {
		ButtonRounded(iconName: "sparkles", text: "Update Stage")
			.onTapGesture { viewModel.showUpdateStageLoadingView.toggle() }
	}
	
	private var addPostButton: some View {
		ButtonCircle(icon: "icon-plus")
			.onTapGesture {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
					viewModel.showingAddPostOptions.toggle()
				}
			}
			.rotationEffect(viewModel.showingAddPostOptions ? .degrees(45) : .degrees(0))
	}
	
	private var darkOverlay: some View {
		Color.black.opacity(0.30)
			.ignoresSafeArea()
			.onTapGesture {
				viewModel.showingAddPostOptions = false
			}
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
