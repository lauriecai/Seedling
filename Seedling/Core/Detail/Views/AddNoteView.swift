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
	
	@FocusState private var keyboardFocused: Bool
	
	init(viewModel: DetailViewModel) {
		self.viewModel = viewModel
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
			.navigationTitle(viewModel.editingExistingNote ? "Edit Note" : "New Note")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { backButton }
				ToolbarItem(placement: .topBarTrailing) {
					if viewModel.editingExistingNote {
						saveChangesButton
					} else {
						addNoteButton
					}
				}
			}
			.keyboardType(.default)
			.onChange(of: viewModel.plantStage) { viewModel.plantStageUpdated = true }
			.onChange(of: viewModel.noteTitle) { viewModel.noteEdited = true }
			.onChange(of: viewModel.noteBodyText) { viewModel.noteEdited = true }
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
		TextInput(inputHeader: "Title", inputPlaceholder: "e.g. It sprouted!", headerDescription: nil, text: $viewModel.noteTitle)
	}
	
	private var noteBodyInput: some View {
		TextEditorInput(inputHeader: "Description", inputPlaceholder: "Start writing...", text: $viewModel.noteBodyText)
	}
	
	private var plantStageSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: $viewModel.plantStage, selectedIndex: $viewModel.selectedStageIndex)
			
			Text(viewModel.plantStage.definition)
				.font(.handjet(.medium, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var addNoteButton: some View {
		Button("Add Note") {
			if viewModel.plantStageUpdated {
				viewModel.updatePlantStage(plant: viewModel.plant, newStage: viewModel.plantStage)
			}
			
			if !viewModel.noteBodyText.isEmpty || !viewModel.noteTitle.isEmpty {
				viewModel.addNote(for: viewModel.plant, title: viewModel.noteTitle, body: viewModel.noteBodyText)
			}
			
			viewModel.resetAddNoteFormInputs()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.noteTitle.isEmpty && viewModel.noteBodyText.isEmpty && !viewModel.plantStageUpdated ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.noteTitle.isEmpty && viewModel.noteBodyText.isEmpty && !viewModel.plantStageUpdated)
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			if let selectedNote = viewModel.selectedNote {
				viewModel.updateNoteTitleAndBody(
					for: selectedNote,
					title: viewModel.noteTitle,
					body: viewModel.noteBodyText
				)
			}
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.noteEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.noteEdited)
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


