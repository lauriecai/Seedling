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
	
	@State private var name = ""
	@State private var variety = ""
	@State private var stage: PlantStage = .seed
	@State private var type: PlantType = .vegetable
	
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
					ToolbarItem(placement: .topBarLeading) {
//						HStack(spacing: 5) {
//							Image(systemName: "chevron.left")
//								.font(.handjet(.medium, size: 18))
							Text("Cancel")
								.font(.handjet(.medium, size: 22))
//						}
						.foregroundStyle(Color.theme.textSecondary)
						.onTapGesture { dismiss() }
					}
					
					ToolbarItem(placement: .topBarTrailing) {
						saveButton
					}
				}
			}
		}
	}
}

#Preview {
    AddPlantView()
}

extension AddPlantView {
	
	private var plantTextInput: some View {
		textInput(inputHeader: "Name", inputPlaceholder: "e.g. Tomato", name: $name)
	}
	
	private var plantVarietyInput: some View {
		textInput(inputHeader: "Variety", inputPlaceholder: "e.g. Beefsteak, Roma", name: $variety)
	}
	
	private var plantStageSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: $stage)
			
			Text(stage.definition)
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var plantTypeSelection: some View {
		VStack(alignment: .leading, spacing: 10) {
			ButtonPillRow(rowLabel: "Type", items: PlantType.allCases, selectedItem: $type)
		}
	}
	
	private var saveButton: some View {
		Button("Add") {
			viewModel.addPlant(
				type: type.rawValue,
				name: name,
				variety: variety,
				stage: stage.rawValue
			)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 22))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
}
