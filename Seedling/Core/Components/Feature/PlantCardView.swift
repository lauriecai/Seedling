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
		VStack(spacing: 0) {
			lightReflection
			plantContent
			shadow
		}
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension PlantCardView {
	
	private var plantContent: some View {
		HStack(alignment: .center) {
			plantNameAndStage
			Spacer()
			plantActions
		}
		.padding(.horizontal)
		.padding(.vertical, 10)
		.background(Color.theme.backgroundSecondary)
	}
	
	private var plantNameAndStage: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(plant.wrappedVariety.isEmpty ? plant.wrappedName : "\(plant.wrappedName): \(plant.wrappedVariety)")
				.font(.handjet(.bold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
				.lineLimit(1)
				.truncationMode(.tail)
			
			HStack(alignment: .center) {
				Text(plant.wrappedStage)
					.font(.handjet(.regular, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
			}
		}
	}
	
	private var plantActions: some View {
		HStack(alignment: .center, spacing: 20) {
			ChevronRight()
			moreOptions
		}
	}
	
	private var moreOptions: some View {
		Button {
			FirebaseEventManager.shared.logEvent(name: "plantActions_tapped")
			showActionSheet = true
			showActionForPlant = plant
		} label: {
			MenuKebab()
				.frame(maxHeight: .infinity)
				.rotationEffect(.degrees(-90))
		}
	}
	
	private var lightReflection: some View {
		Rectangle()
			.frame(height: 8)
			.foregroundStyle(Color.white).opacity(0.5)
	}
	
	private var shadow: some View {
		Rectangle()
			.frame(height: 8)
			.foregroundStyle(Color.theme.textSecondary).opacity(0.50)
	}
}
