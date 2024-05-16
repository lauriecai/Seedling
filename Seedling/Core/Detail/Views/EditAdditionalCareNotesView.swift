//
//  EditAdditionalCareNotesView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/15/24.
//

import SwiftUI

struct EditAdditionalCareNotesView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.white.ignoresSafeArea()
				
				ScrollView {
					VStack(alignment: .leading, spacing: 15) {
						header
						
						TextEditor(text: $viewModel.additionalCareNotesInput)
							.font(.handjet(.medium, size: 22))
							.scrollContentBackground(.hidden)
							.padding(.horizontal, 12)
							.padding(.vertical, 6)
							.background(Color.theme.backgroundGrey)
							.foregroundStyle(Color.theme.textPrimary)
							.frame(height: 500)
							.clipShape(RoundedRectangle(cornerRadius: 8))
							.autocorrectionDisabled()
					}
					.padding(.horizontal)
				}
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { cancelButton }
				ToolbarItem(placement: .topBarTrailing) { saveChangesButton }
			}
			.onChange(of: viewModel.additionalCareNotesInput) {
				viewModel.plantAdditionalCareNotesEdited = true
			}
		}
    }
}

extension EditAdditionalCareNotesView {
	
	private var header: some View {
		HStack {
			Text("Additional Care Notes: \(viewModel.plant.wrappedName)")
				.font(.handjet(.extraBold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
			Spacer()
		}
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if viewModel.plantAdditionalCareNotesEdited {
				viewModel.editPlantAdditionalCareNotes(for: viewModel.plant)
			}
			viewModel.resetPlantAdditionalCareNotesEditedFlag()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantAdditionalCareNotesEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantAdditionalCareNotesEdited)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			viewModel.resetPlantAdditionalCareNotesEditedFlag()
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
