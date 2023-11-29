//
//  PlantRowView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct PlantRowView: View {
    var body: some View {
		VStack(alignment: .leading) {
			// plant name
			Text("Jalapeno")
				.font(.handjet(.bold, size: 24))
			
			// plant properties
			HStack {
				// form
				Text("Seed")
					.font(.handjet(.regular, size: 18))
				
				Spacer()
				
				// stage, duration
				HStack(spacing: 4) {
					Text("Acquired")
						.font(.handjet(.regular, size: 18))
					Text("(2 days)")
						.font(.handjet(.regular, size: 18))
						.foregroundStyle(Color.theme.textSecondary)
				}
			}
		}
		.frame(maxWidth: .infinity)
		.padding()
		.background(Color.theme.backgroundLight)
		.cornerRadius(8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PlantRowView()
}
