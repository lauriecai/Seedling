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
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			postsList

			addNoteButton
		}
		.navigationTitle(viewModel.plant.wrappedFullNameLabel)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.onAppear {
			viewModel.fetchPosts(for: viewModel.plant)
		}
		.navigationDestination(isPresented: $viewModel.showAddNoteLoadingView) {
			if viewModel.showAddNoteLoadingView {
				AddNoteLoadingView(viewModel: viewModel)
			}
		}
    }
}

// MARK: - UI

extension DetailView {
	
	private var postsList: some View {
		ScrollView {
			ForEach(viewModel.posts) { post in
				switch post.type {
				case .event(let event):
					eventCard(for: event)
						.confirmationDialog("Event Options", isPresented: $viewModel.showEventActionSheet) {
							editEventButton
							deleteEventButton
						} message: {
							Text("What do you want to do with this event?")
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
		Button("Edit event") {
			print("Add note view edit event triggered!")
		}
	}
	
	private var deleteEventButton: some View {
		Button("Delete event", role: .destructive) {
			if let selectedEvent = viewModel.selectedEvent {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.25)) {
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
			print("Add note view edit note triggered!")
		}
	}
	
	private var deleteNoteButton: some View {
		Button("Delete note", role: .destructive) {
			if let selectedNote = viewModel.selectedNote {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.25)) {
					viewModel.deleteNote(note: selectedNote)
				}
			}
		}
	}
	
	private var addNoteButton: some View {
		ButtonCircle(icon: "icon-plus")
			.onTapGesture { viewModel.showAddNoteLoadingView.toggle() }
			.padding(.trailing, 20)
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
