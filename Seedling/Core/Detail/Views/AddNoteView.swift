//
//  AddNoteView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/18/24.
//

import SwiftUI

struct AddNoteLoadingView: View {
	
	let viewModel: DetailViewModel
	
	var body: some View {
		AddNoteView(viewModel: viewModel)
	}
}

struct AddNoteView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State private var title: String = ""
	@State private var bodyText: String = ""
	@State private var stage: PlantStage
	@State private var selectedIndex: Int
	@State private var stageUpdated: Bool = false
	
	@FocusState private var keyboardFocused: Bool
	
	init(viewModel: DetailViewModel) {
		self.viewModel = viewModel
		_stage = State(wrappedValue: PlantStage(rawValue: viewModel.plant.wrappedStage)!)
		_selectedIndex = State(wrappedValue: PlantStage.allCases.firstIndex(of: PlantStage(rawValue: viewModel.plant.wrappedStage)!)!)
	}
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView {
					VStack(spacing: 15) {
						notePrompt
						noteTitleInput
							.focused($keyboardFocused)
							.onAppear { keyboardFocused.toggle() }
						noteBodyInput
						plantStageSelection
					}
					.padding()
				}
			}
			.navigationTitle("New Note")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { backButton }
				ToolbarItem(placement: .topBarTrailing) { addNoteButton }
			}
			.keyboardType(.default)
			.onChange(of: stage) { stageUpdated.toggle() }
		}
    }
}

extension AddNoteView {
	
	private var notePrompt: some View {
		Text("How's your \(viewModel.plant.wrappedFullNameSentence.lowercased())?")
			.font(.handjet(.extraBold, size: 26))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var noteTitleInput: some View {
		TextInput(inputHeader: "Title", inputPlaceholder: "e.g. It sprouted!", headerDescription: "Optional", text: $title)
	}
	
	private var noteBodyInput: some View {
		TextEditorInput(inputHeader: "Description", inputPlaceholder: "Start writing...", text: $bodyText)
	}
	
	private var plantStageSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: $stage, selectedIndex: $selectedIndex)
			
			Text(stage.definition)
				.font(.handjet(.medium, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var addNoteButton: some View {
		Button("Add Note") {
			if stageUpdated {
				viewModel.updatePlant(plant: viewModel.plant, newStage: stage)
			}
			
			if !bodyText.isEmpty {
				viewModel.addNote(for: viewModel.plant, title: title, body: bodyText)
			}
			
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(bodyText.isEmpty && !stageUpdated ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(bodyText.isEmpty && !stageUpdated)
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


