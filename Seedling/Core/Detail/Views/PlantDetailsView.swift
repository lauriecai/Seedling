//
//  PlantDetailsView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/9/24.
//

import SwiftUI

struct PlantDetailsLoadingView: View {
	
	let viewModel: DetailViewModel
	
	var body: some View {
		PlantDetailsView(viewModel: viewModel)
	}
}

struct PlantDetailsView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView {
				VStack(spacing: 10) {
					generalDetailsCard
					careRequirementsCard
					additionalCareNotesCard
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle("Plant Details")
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
		}
		.sheet(isPresented: $viewModel.editingGeneralDetails) { EditGeneralDetailsCardView(viewModel: viewModel)
		}
    }
}

extension PlantDetailsView {
	
	// General Details card
	
	private var generalDetailsCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			generalDetailsCardHeader
			generalDetailsCardProperties
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	
	private var generalDetailsCardHeader: some View {
		HStack {
			CardTitle(title: "General")
			Spacer()
			editGeneralDetailsButton
		}	
	}
	
	private var generalDetailsCardProperties: some View {
		VStack(alignment: .leading, spacing: 15) {
			PropertyLabel(label: "Name", value: viewModel.plant.wrappedName)
			PropertyLabel(label: "Variety", value: viewModel.plant.wrappedVariety.isEmpty ? "-" : viewModel.plant.wrappedVariety)
			PropertyLabel(label: "Type", value: viewModel.plant.wrappedType)
			PropertyLabel(label: "Stage", value: viewModel.plant.wrappedStage)
		}
	}
	
	private var editGeneralDetailsButton: some View {
		Button("Edit") {
			viewModel.resetGeneralDetailsEditedFlag()
			
			viewModel.editingGeneralDetails = true
			viewModel.fetchPlantGeneralDetails(for: viewModel.plant)
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
	private var saveGeneralDetailsButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if viewModel.plantGeneralDetailsEdited {
				viewModel.editPlantGeneralDetails(for: viewModel.plant)
			}
			viewModel.resetGeneralDetailsEditedFlag()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantGeneralDetailsEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantGeneralDetailsEdited)
	}
	
	// Care Requirements card
	
	private var careRequirementsCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			careRequirementsCardHeader
			careRequirementsCardProperties
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	
	private var careRequirementsCardHeader: some View {
		HStack {
			CardTitle(title: "Care Requirements")
			
			Spacer()
			
			if viewModel.editingCareRequirements {
				saveCareRequirementsButton
			} else {
				editCareRequirementsButton
			}
		}
	}
	
	private var careRequirementsCardProperties: some View {
		VStack(alignment: .leading, spacing: 15) {
			PropertyLabel(iconName: "sun.max.fill", label: "Sunlight", value: viewModel.plant.sunlightRequirement ?? "-")
			PropertyLabel(iconName: "thermometer.medium", label: "Temperature", value: viewModel.plant.temperatureRequirement ?? "-")
			PropertyLabel(iconName: "drop.fill", label: "Water", value: viewModel.plant.waterRequirement ?? "-")
			PropertyLabel(iconName: "water.waves", label: "Humidity", value: viewModel.plant.humidityRequirement ?? "-")
			PropertyLabel(iconName: "button.angledbottom.horizontal.right", label: "Soil", value: viewModel.plant.soilRequirement ?? "-")
			PropertyLabel(iconName: "aqi.low", label: "Fertilizer", value: viewModel.plant.fertilizerRequirement ?? "-")
		}
	}
	
	private var saveCareRequirementsButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if viewModel.plantCareRequirementsEdited {
				viewModel.editPlantCareRequirements(for: viewModel.plant)
			}
			viewModel.resetCareRequirementsEditedFlag()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantCareRequirementsEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantCareRequirementsEdited)
	}
	
	private var editCareRequirementsButton: some View {
		Button("Edit") {
			viewModel.editingCareRequirements = true
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
	// Additional Care Notes card
	
	private var additionalCareNotesCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			additionalCareNotesCardHeader
			additionalCareNotes
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	
	private var additionalCareNotesCardHeader: some View {
		HStack {
			CardTitle(title: "Additional Care Notes")
			
			Spacer()
			
			if viewModel.editingAdditionalCareNotes {
				saveAdditionalCareNotesButton
			} else {
				editAdditionalCareNotesButton
			}
		}
	}
	
	private var additionalCareNotes: some View {
		Text(viewModel.plant.additionalCareNotes ?? "-")
			.font(.handjet(.medium, size: 22))
			.foregroundStyle(Color.theme.textPrimary)
	}
	
	private var editAdditionalCareNotesButton: some View {
		Button("Edit") {
			viewModel.editingAdditionalCareNotes = true
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
	private var saveAdditionalCareNotesButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if viewModel.plantAdditionalCareNotesEdited {
				viewModel.editAdditionalCareNotes(for: viewModel.plant)
			}
			viewModel.resetAdditionalCareNotesEditedFlag()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantAdditionalCareNotesEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantAdditionalCareNotesEdited)
	}
	
	// Other
	
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
	
	struct CardTitle: View {
		
		let title: String
		
		var body: some View {
			Text(title)
				.font(.handjet(.extraBold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
		}
	}
	
	struct PropertyLabel: View {
		
		let iconName: String?
		let label: String
		let value: String
		
		init(label: String, value: String) {
			self.iconName = nil
			self.label = label
			self.value = value
		}
		init(iconName: String, label: String, value: String) {
			self.iconName = iconName
			self.label = label
			self.value = value
		}
		
		var body: some View {
			HStack(alignment: .center, spacing: 10) {
				
				if let image = iconName {
					ZStack {
						Color.theme.textGrey.opacity(0.25)
							.frame(width: 40, height: 40)
							.clipShape(RoundedRectangle(cornerRadius: 8))
						
						Image(systemName: image)
							.resizable()
							.scaledToFit()
							.frame(width: 24, height: 24)
							.foregroundStyle(Color.theme.textPrimary)
					}
				}
				
				VStack(alignment: .leading, spacing: 2) {
					Text(label)
						.font(.handjet(.bold, size: 16))
						.foregroundStyle(Color.theme.textGrey)
					
					Text(value)
						.font(.handjet(.medium, size: 22))
						.foregroundStyle(Color.theme.textPrimary)
				}
			}
		}
	}
}
