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
	
	@State private var showNoteActionSheet: Bool = false
	@State private var selectedNote: Note? = nil
	
	@State private var showEventActionSheet: Bool = false
	@State private var selectedEvent: Event? = nil
	
	@State private var showingAddNoteLoadingView: Bool = false
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView {
				eventsList
				notesList
			}
			.padding(.horizontal)
			
			addNoteButton
		}
		.navigationTitle(viewModel.plant.wrappedFullNameLabel)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.onAppear {
			viewModel.fetchNotesAndEvents(for: viewModel.plant)
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
	
	private var eventsList: some View {
		ForEach(viewModel.events) { event in
			EventCardView(event: event, showActionSheet: $showEventActionSheet, showActionsForEvent: $selectedEvent)
		}
		.actionSheet(isPresented: $showEventActionSheet) {
			ActionSheet(
				title: Text("Event options"),
				buttons: [
					.destructive(Text("Delete event")) {
						if let selectedEvent = selectedEvent {
							withAnimation(Animation.easeInOut(duration: 0.4)) {
								viewModel.deleteEvent(event: selectedEvent)
								viewModel.fetchEvents(for: viewModel.plant)
							}
						}
					},
					.cancel()
				]
			)
		}
	}
	
	private var notesList: some View {
		ForEach(viewModel.notes) { note in
			NoteCardView(note: note, showPlantTag: false, showActionSheet: $showNoteActionSheet, showActionsForNote: $selectedNote)
		}
		.actionSheet(isPresented: $showNoteActionSheet) {
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
	}
	
	private var addNoteButton: some View {
		ButtonCircle(icon: "icon-plus")
			.onTapGesture { showingAddNoteLoadingView.toggle() }
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
