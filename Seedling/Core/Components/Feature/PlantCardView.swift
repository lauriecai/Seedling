//
//  PlantCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct PlantCardView: View {
	
	let plant: Plant
	
    var body: some View {
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
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
