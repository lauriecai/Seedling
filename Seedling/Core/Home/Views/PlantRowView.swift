//
//  PlantRowView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct PlantRowView: View {
	
	let plant: Plant
	
    var body: some View {
		VStack(alignment: .leading) {
			// plant name
			if !plant.wrappedVariety.isEmpty {
				Text("\(plant.wrappedName): \(plant.wrappedVariety)")
					.font(.handjet(.bold, size: 24))
					.foregroundStyle(Color.theme.textPrimary)
			} else {
				Text(plant.wrappedName)
					.font(.handjet(.bold, size: 24))
					.foregroundStyle(Color.theme.textPrimary)
			}
			
			// plant properties
			HStack {
				// stage
				Text(plant.wrappedStage)
					.font(.handjet(.regular, size: 18))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
			}
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
