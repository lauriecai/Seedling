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
				switch post.entity {
				case .event(let event):
					EventCardView(event: event, showActionSheet: $viewModel.showEventActionSheet, showActionsForEvent: $viewModel.selectedEvent)
						.actionSheet(isPresented: $viewModel.showEventActionSheet) {
							ActionSheet(
								title: Text("Event options"),
								buttons: [
									.destructive(Text("Delete event")) {
										if let selectedEvent = viewModel.selectedEvent {
											withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.25)) {
												viewModel.deleteEvent(event: selectedEvent)
											}
										}
									},
									.cancel()
								]
							)
						}
				case .note(let note):
					NoteCardView(note: note, showPlantTag: false, showActionSheet: $viewModel.showNoteActionSheet, showActionsForNote: $viewModel.selectedNote)
						.actionSheet(isPresented: $viewModel.showNoteActionSheet) {
							ActionSheet(
								title: Text("Note options"),
								buttons: [
									.destructive(Text("Delete note")) {
										if let selectedNote = viewModel.selectedNote {
											withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.25)) {
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
			.padding(.horizontal)
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
