//
//  EventCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/15/24.
//

import SwiftUI

struct EventCardView: View {
	
	let previousStage: String
	let newStage: String
	
    var body: some View {
		HStack() {
			Text(previousStage)
				.fontWeight(.bold)
			Text("to")
			Text(newStage)
				.fontWeight(.bold)
			Spacer()
		}
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color.theme.backgroundDark)
		.font(.handjet(.regular, size: 18))
		.foregroundStyle(Color.theme.textLight)
    }
}

#Preview {
	EventCardView(previousStage: "Seed", newStage: "Seedling")
}
