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
					generalCard
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
    }
}

extension PlantDetailsView {
	
	private var generalCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			cardHeader(cardTitle: "General", editTapped: <#Binding<Bool>#>)
			
			VStack(alignment: .leading, spacing: 15) {
//				LabelProperty(label: "Name", value: viewModel.plant.wrappedName)
//				LabelProperty(label: "Variety", value: viewModel.plant.variety ?? "-")
//				LabelProperty(label: "Scientific Name", value: viewModel.plant.scientificName ?? "-")
//				LabelProperty(label: "Type", value: viewModel.plant.wrappedType)
//				LabelProperty(label: "Stage", value: viewModel.plant.wrappedStage)
				
				LabelProperty(label: "Name", value: "Green Onion")
				LabelProperty(label: "Variety", value: "Evergreen Bunching")
				LabelProperty(label: "Scientific Name", value: "Allium Fistulosum")
				LabelProperty(label: "Type", value: "Vegetable")
				LabelProperty(label: "Stage", value: "Seed")
			}
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	
	private var careRequirementsCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			cardHeader(cardTitle: "Care Requirements", editTapped: <#Binding<Bool>#>)
			
			VStack(alignment: .leading, spacing: 15) {
//				LabelProperty(iconName: "sun.max.fill", label: "Sunlight", value: viewModel.plant.sunlightRequirement ?? "-")
//				LabelProperty(iconName: "thermometer.medium", label: "Temperature", value: viewModel.plant.temperatureRequirement ?? "-")
//				LabelProperty(iconName: "drop.fill", label: "Water", value: viewModel.plant.waterRequirement ?? "-")
//				LabelProperty(iconName: "water.waves", label: "Humidity", value: viewModel.plant.humidityRequirement ?? "-")
//				LabelProperty(iconName: "button.angledbottom.horizontal.right", label: "Soil", value: viewModel.plant.soilRequirement ?? "-")
//				LabelProperty(iconName: "aqi.low", label: "Fertilizer", value: viewModel.plant.fertilizerRequirement ?? "-")
				
				LabelProperty(iconName: "sun.max", label: "Sunlight", value: "Medium")
				LabelProperty(iconName: "thermometer.medium", label: "Temperature", value: "Cool-ish weather (75F and under) but not too cold (under 50F)")
				LabelProperty(iconName: "drop", label: "Water", value: "Medium")
				LabelProperty(iconName: "humidity", label: "Humidity", value: "Low")
				LabelProperty(iconName: "button.angledbottom.horizontal.right", label: "Soil", value: "Compost-heavy, light and fluffy")
				LabelProperty(iconName: "aqi.low", label: "Fertilizer", value: "Pure Gold Organic & Natural All Purpose Fertilizer and some coffee grounds. They LOVE coffee grounds!")
			}
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
	
	private var additionalCareNotesCard: some View {
		VStack(alignment: .leading, spacing: 15) {
			cardHeader(cardTitle: "Additional Care Notes", editTapped: <#Binding<Bool>#>)
			
			VStack(alignment: .leading, spacing: 10) {
				Text("These guys don't need any pruning, but are very sensitive to heat. Keep an eye out for aphids. No pesticides and fertilize once a month.")
					.font(.handjet(.medium, size: 22))
					.foregroundStyle(Color.theme.textPrimary)
				
				Text("Keep an eye out for aphids. No pesticides! Spray off with spray bottle.")
					.font(.handjet(.medium, size: 22))
					.foregroundStyle(Color.theme.textPrimary)
				
				Text("Fertilize once a month.")
					.font(.handjet(.medium, size: 22))
					.foregroundStyle(Color.theme.textPrimary)
			}
		}
		.padding()
		.background(Color.white)
		.clipShape(RoundedRectangle(cornerRadius: 8))
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
	
	struct cardHeader: View {
		
		let cardTitle: String
		@Binding var editTapped: Bool
		
		var body: some View {
			HStack {
				Text(cardTitle)
					.font(.handjet(.extraBold, size: 24))
					.foregroundStyle(Color.theme.textPrimary)
				Spacer()
				Button {
					editTapped = true
				} label: {
					Text("Edit")
						.font(.handjet(.extraBold, size: 18))
						.foregroundStyle(Color.theme.accentGreen)
				}
			}
		}
	}
}
