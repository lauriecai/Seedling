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
			Text("\(plant.name ?? ""): \(plant.variety ?? "")")
				.font(.handjet(.bold, size: 24))
			
			// plant properties
			HStack {
				// stage
				Text(plant.stage ?? "")
					.font(.handjet(.regular, size: 18))
				
				Spacer()
			}
		}
		.frame(maxWidth: .infinity)
		.padding()
		.background(Color.theme.backgroundLight)
		.cornerRadius(8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	PlantRowView(plant: <#T##Plant#>)
}
