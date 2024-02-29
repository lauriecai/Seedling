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
		print("Initializing DetailView for \(plant.wrappedName)...")
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
		print("DetailView initialized for \(plant.wrappedName)!")
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			notesList
			addNoteButton
				.padding(.trailing, 20)
		}
		.navigationTitle(viewModel.plant.wrappedFullNameLabel)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.onAppear { viewModel.fetchNotes(for: viewModel.plant) }
    }
}

extension DetailView {
	
	private var notesList: some View {
		ScrollView {
			ForEach(viewModel.notes) { note in
				NoteCardView(note: note)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.horizontal)
	}
	
	private var addNoteButton: some View {
		NavigationLink(destination: AddNoteView(viewModel: viewModel)) {
			ButtonCircle(icon: "PlusIcon")
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
