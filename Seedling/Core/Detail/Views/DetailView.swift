//
//  DetailView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import SwiftUI

struct DetailView: View {
	
	@StateObject private var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
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
			ToolbarItem(placement: .topBarTrailing) { detailsButton }
		}
		.onAppear {
			viewModel.fetchPosts(for: viewModel.plant)
			viewModel.showingAddPostOptions = false
		}
		.sheet(isPresented: $viewModel.showingAddNoteView) {
			NavigationView {
				AddNoteView(viewModel: viewModel)
			}
		}
		.sheet(isPresented: $viewModel.showingUpdateStageView) {
			NavigationView {
				UpdateStageView(viewModel: viewModel)
			}
		}
		.navigationDestination(isPresented: $viewModel.showingPlantDetailsView) {
			PlantDetailsView(viewModel: viewModel)
		}
    }
}

// MARK: - UI

extension DetailView {
	
	private var postsList: some View {
		ScrollView(showsIndicators: false) {
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
			.padding(.bottom, 160)
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
		NoteCardView(note: note, showActionSheet: $viewModel.showNoteActionSheet, showActionsForNote: $viewModel.selectedNote)
	}
	
	private var editNoteButton: some View {
		Button("Edit note") {
			viewModel.resetNoteEditedFlag()
			
			if let selectedNote = viewModel.selectedNote {
				viewModel.editingExistingNote = true
				viewModel.showingAddNoteView = true
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
		.padding(.bottom, 85)
	}
	
	private var addPostOptionsButtons: some View {
		VStack(alignment: .trailing, spacing: 12) {
			addNoteButton
			updateStageButton
		}
	}
	
	private var addNoteButton: some View {
		ButtonRounded(iconName: "pencil", text: "Add Note")
			.onTapGesture {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				viewModel.showingAddNoteView.toggle()
			}
	}
	
	private var updateStageButton: some View {
		ButtonRounded(iconName: "sparkles", text: "Update Stage")
			.onTapGesture {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				viewModel.showingUpdateStageView = true
			}
	}
	
	private var addPostButton: some View {
		ButtonCircle(iconName: "icon-plus")
			.onTapGesture {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
	
	private var detailsButton: some View {
		Button {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			viewModel.showingPlantDetailsView.toggle()
		} label: {
			Text("Details")
				.font(.handjet(.extraBold, size: 20))
				.foregroundStyle(Color.theme.accentGreen)
		}
	}
}
