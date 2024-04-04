//
//  PlantCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct PlantCardView: View {
	
	let plant: Plant
	
	@Binding var showActionSheet: Bool
	@Binding var showActionForPlant: Plant?
	
    var body: some View {
		HStack(alignment: .center) {
			plantNameAndStage
			plantActions
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension PlantCardView {
	private var plantNameAndStage: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(plant.wrappedVariety.isEmpty ? plant.wrappedName : "\(plant.wrappedName): \(plant.wrappedVariety)")
				.font(.handjet(.bold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
			
			HStack {
				Text(plant.wrappedStage)
					.font(.handjet(.regular, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
			}
		}
	}
	
	private var plantActions: some View {
		Button {
			showActionSheet = true
			showActionForPlant = plant
		} label: {
			MenuKebab()
				.frame(maxHeight: .infinity)
				.rotationEffect(.degrees(-90))
		}
	}
}
