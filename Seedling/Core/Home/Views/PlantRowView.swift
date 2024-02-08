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
			if let hasVariety = plant.variety {
				Text("\(plant.name ?? ""): \(plant.variety ?? "")")
					.font(.handjet(.bold, size: 24))
			} else {
				Text("\(plant.name ?? "")")
					.font(.handjet(.bold, size: 24))
			}
			
			// plant properties
			HStack {
				// stage
				Text("\(plant.stage ?? "")")
					.font(.handjet(.regular, size: 18))
				
				Spacer()
			}
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//#Preview(traits: .sizeThatFitsLayout) {
//	PlantRowView()
//}
