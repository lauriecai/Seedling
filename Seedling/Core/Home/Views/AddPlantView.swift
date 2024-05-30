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
				
				ScrollView(showsIndicators: false) {
					VStack(spacing: 15) {
						plantTextInput
							.focused($keyboardFocused)
							.onAppear { keyboardFocused.toggle() }
						
						plantVarietyInput
						
						if !viewModel.editingExistingPlant {
							plantStageSelection
							plantTypeSelection
						}
					}
					.padding(.horizontal)
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
				.onChange(of: viewModel.plantName) { viewModel.plantDetailsEdited = true }
				.onChange(of: viewModel.plantVariety) { viewModel.plantDetailsEdited = true }
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
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, accentTheme: true, selectedItem: $viewModel.plantStage, selectedIndex: $viewModel.selectedStageIndex)
			
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
			ButtonPillRow(rowLabel: "Type", items: PlantType.allCases, accentTheme: true, selectedItem: $viewModel.plantType, selectedIndex: $viewModel.selectedTypeIndex)
		}
	}
	
	private var addPlantButton: some View {
		Button("Add Plant") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			viewModel.addPlant(
				name: viewModel.plantName,
				variety: viewModel.plantVariety,
				stage: viewModel.plantStage.rawValue,
				type: viewModel.plantType.rawValue
			)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantName.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.plantName.isEmpty)
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if let selectedPlant = viewModel.selectedPlant {
				viewModel.updatePlantNameAndVariety(
					for: selectedPlant,
					name: viewModel.plantName,
					variety: viewModel.plantVariety
				)
			}
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantDetailsEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantDetailsEdited)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			viewModel.resetAddPlantFormInputsAndFlags()
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
