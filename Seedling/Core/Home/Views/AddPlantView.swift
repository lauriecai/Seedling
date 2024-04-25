//
//  AddPlantView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/9/24.
//

import SwiftUI

struct AddPlantView: View {
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@FocusState private var keyboardFocused: Bool
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView {
					VStack(spacing: 15) {
						plantTextInput
							.focused($keyboardFocused)
							.onAppear { keyboardFocused.toggle() }
						plantVarietyInput
						plantStageSelection
						plantTypeSelection
					}
					.padding()
				}
				.navigationTitle(viewModel.editingExistingPlant ? "Edit Plant" : "New Plant")
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarBackButtonHidden(true)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) { cancelButton }
					ToolbarItem(placement: .topBarTrailing) {
						if viewModel.editingExistingPlant {
							saveChangesButton
						} else {
							addPlantButton
						}
					}
				}
				.keyboardType(.default)
				.autocorrectionDisabled()
			}
		}
	}
}

#Preview {
    AddPlantView()
}

extension AddPlantView {
	
	private var plantTextInput: some View {
		TextInput(inputHeader: "Name", inputPlaceholder: "e.g. Tomato", headerDescription: nil, text: $viewModel.plantName)
	}
	
	private var plantVarietyInput: some View {
		TextInput(inputHeader: "Variety", inputPlaceholder: "e.g. Beefsteak, Roma", headerDescription: "Optional", text: $viewModel.plantVariety)
	}
	
	private var plantStageSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: $viewModel.plantStage, selectedIndex: $viewModel.selectedStageIndex)
			
			selectedPlantStageDefinition
		}
	}
	
	private var selectedPlantStageDefinition: some View {
		Text(viewModel.plantStage.definition)
			.font(.handjet(.medium, size: 18))
			.foregroundStyle(Color.theme.textSecondary)
	}
	
	private var plantTypeSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Type", items: PlantType.allCases, selectedItem: $viewModel.plantType, selectedIndex: $viewModel.selectedTypeIndex)
		}
	}
	
	private var addPlantButton: some View {
		Button("Add Plant") {
			viewModel.addPlant(
				type: viewModel.plantType.rawValue,
				name: viewModel.plantName,
				variety: viewModel.plantVariety,
				stage: viewModel.plantStage.rawValue
			)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantName.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.plantName.isEmpty)
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			print("Changes saved.")
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantName.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.plantName.isEmpty)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			viewModel.resetAddPlantFormInputs()
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
