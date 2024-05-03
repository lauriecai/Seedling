//
//  StageCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct CardSelectable: View {
	
	let title: String
	let description: String?
	
	let currentlyActivePillText: String
	let isCurrentlyActive: Bool
	
	let newlySelectedPillText: String
	let isNewlySelected: Bool
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			HStack(spacing: 8) {
				Text(title)
					.font(.handjet(.bold, size: 24))
					.opacity(isCurrentlyActive ? 0.5 : 1.0)
				
				if isCurrentlyActive {
					TextPill(label: currentlyActivePillText, backgroundColor: Color.theme.backgroundLight)
				}
				
				if isNewlySelected {
					TextPill(label: newlySelectedPillText, backgroundColor: Color.theme.accentYellow)
				}
			}
			
			if let description = description {
				Text(description)
					.font(.handjet(.medium, size: 20))
					.opacity(isCurrentlyActive ? 0.5 : 1.0)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color.theme.backgroundAccent)
		.overlay(isNewlySelected ? selectedBorder : nil)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
	CardSelectable(
		title: "Seedling",
		description: "A young plant with its first set of leaves.",
		currentlyActivePillText: "Current Stage",
		isCurrentlyActive: true,
		newlySelectedPillText: "New Stage",
		isNewlySelected: false
	)
}

extension CardSelectable {
	
	private var selectedBorder: some View {
		RoundedRectangle(cornerRadius: 8)
			.stroke(Color.theme.textPrimary, lineWidth: 8)
	}
}
