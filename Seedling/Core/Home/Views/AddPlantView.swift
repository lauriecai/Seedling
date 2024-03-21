//
//  AddPlantView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/9/24.
//

import SwiftUI

struct AddPlantView: View {
	
	let dataManager = CoreDataManager.shared
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State private var name = ""
	@State private var variety = ""
	
	@State private var stage: PlantStage = .seed
	@State private var selectedStageIndex: Int = 0
	
	@State private var type: PlantType = .vegetable
	@State private var selectedTypeIndex: Int = 0
	
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
				.navigationTitle("New Plant")
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarBackButtonHidden(true)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) { cancelButton }
					ToolbarItem(placement: .topBarTrailing) { addPlantButton }
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
		TextInput(inputHeader: "Name", inputPlaceholder: "e.g. Tomato", headerDescription: nil, text: $name)
	}
	
	private var plantVarietyInput: some View {
		TextInput(inputHeader: "Variety", inputPlaceholder: "e.g. Beefsteak, Roma", headerDescription: "Optional", text: $variety)
	}
	
	private var plantStageSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: $stage, selectedIndex: $selectedStageIndex)
			
			Text(stage.definition)
				.font(.handjet(.medium, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var plantTypeSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Type", items: PlantType.allCases, selectedItem: $type, selectedIndex: $selectedTypeIndex)
		}
	}
	
	private var addPlantButton: some View {
		Button("Add Plant") {
			viewModel.addPlant(
				type: type.rawValue,
				name: name,
				variety: variety,
				stage: stage.rawValue
			)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(name.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(name.isEmpty)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
