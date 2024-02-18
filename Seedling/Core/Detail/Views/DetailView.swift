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
	
	@State private var showAddNote = false
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
		print("DetailView initialized for \(plant.wrappedName)")
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView {
				ForEach(0..<10) { _ in
					NoteCardView()
				}
			}
			
			addNoteButton
				.onTapGesture { showAddNote.toggle() }
				.padding(.trailing, 20)
		}
		.navigationTitle(viewModel.plant.wrappedFullName)
		.sheet(isPresented: $showAddNote) {
			AddNoteView(plant: viewModel.plant)
		}
    }
}

extension DetailView {
	
	private var addNoteButton: some View {
		NavigationLink(destination: AddNoteView(plant: viewModel.plant)) {
			ButtonCircle(icon: "PlusIcon")
		}
	}
}
