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

	@State private var plant: Plant
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
		_plant = State(initialValue: plant)
		print("DetailView initialized for \(plant.wrappedName)")
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			notesList
			addNoteButton
				.padding(.trailing, 20)
		}
		.navigationTitle(viewModel.plant.wrappedFullName)
		.onAppear { viewModel.fetchNotes(for: plant) }
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				HStack(spacing: 5) {
					Image(systemName: "chevron.left")
						.font(.handjet(.medium, size: 18))
					Text("Back")
						.font(.handjet(.bold, size: 20))
				}
				.foregroundStyle(Color.theme.accentGreen)
				.onTapGesture { dismiss() }
			}
		}
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
	}
	
	private var addNoteButton: some View {
		NavigationLink(destination: AddNoteView(viewModel: DetailViewModel(plant: plant))) {
			ButtonCircle(icon: "PlusIcon")
		}
	}
}
