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
	
	let isSelected: Bool
	let selectedPillLabel: String
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			HStack(spacing: 8) {
				Text(title)
					.font(.handjet(.bold, size: 24))
				
				if isSelected {
					TextPill(label: selectedPillLabel, backgroundColor: Color.theme.accentYellow)
				}
			}
			
			if let description = description {
				Text(description)
					.font(.handjet(.medium, size: 20))
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color.theme.backgroundAccent)
		.overlay(isSelected ? selectedBorder : nil)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
	ScrollView {
		VStack {
			CardSelectable(
				title: "Seed",
				description: "A small object from which a new plant can grow.",
				isSelected: true,
				selectedPillLabel: "Selected"
			)
		}
	}
}

extension CardSelectable {
	
	private var selectedBorder: some View {
		RoundedRectangle(cornerRadius: 8)
			.stroke(Color.theme.textPrimary, lineWidth: 8)
	}
}
