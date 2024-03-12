//
//  AddGeneralNoteView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/11/24.
//

import SwiftUI

struct AddGeneralNoteView: View {
	
	let dataManager = CoreDataManager.shared
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State var selectedIndex: Int
	
	@State private var title: String = ""
	@State private var bodyText: String = ""
	
	@FocusState private var keyboardFocused: Bool
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView {
					VStack(spacing: 15) {
						Dropdown(pickerHeader: "Plant", items: viewModel.plantNames, selectedIndex: $selectedIndex)
						
						noteTitleInput
							.focused($keyboardFocused)
							.onAppear { keyboardFocused.toggle() }
						
						noteBodyInput
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
			.autocorrectionDisabled()
		}
    }
}

extension AddGeneralNoteView {
	
	private var noteTitleInput: some View {
		TextInput(inputHeader: "Title", inputPlaceholder: "e.g. It sprouted!", headerDescription: "Optional", text: $title)
	}
	
	private var noteBodyInput: some View {
		TextEditorInput(inputHeader: "Description", inputPlaceholder: "Start writing...", text: $bodyText)
	}
	
	private var addNoteButton: some View {
		Button("Add Note") {
			dataManager.addNote(
				plant: viewModel.plants[selectedIndex],
				title: title,
				body: bodyText
			)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(bodyText.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(bodyText.isEmpty)
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
