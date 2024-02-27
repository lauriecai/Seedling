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
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView {
					VStack(spacing: 20) {
						plantTextInput
						plantVarietyInput
						
						plantStageSelection
						plantTypeSelection
					}
					.padding()
				}
				.navigationTitle("Add Plant")
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarBackButtonHidden(true)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) {
						HStack(spacing: 5) {
							Image(systemName: "chevron.left")
								.font(.handjet(.medium, size: 18))
							Text("Back")
								.font(.handjet(.bold, size: 20))
						}
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
		let plantStages = PlantStage.allCases.map { $0.rawValue }
		
		return ButtonPillRow(rowLabel: "Stage", items: plantStages)
	}
	
	private var plantTypeSelection: some View {
		let plantTypes = PlantType.allCases.map { $0.rawValue }
		
		return ButtonPillRow(rowLabel: "Type", items: plantTypes)
	}
	
	private var saveButton: some View {
		Button("Save") {
			viewModel.addPlant(
				type: type.rawValue,
				name: name,
				variety: variety,
				stage: stage.rawValue
			)
			dismiss()
		}
		.font(.handjet(.bold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
}
