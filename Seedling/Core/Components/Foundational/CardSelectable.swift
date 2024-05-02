//
//  StageCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct CardSelectable: View {
	
	let title: String
	let bodyText: String
	
	let isCurrentlyActive: Bool
	let currentlyActivePillText: String
	
	let isNewlySelected: Bool
	let newlySelectedPillText: String
	
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
			
			Text(bodyText)
				.font(.handjet(.medium, size: 20))
				.opacity(isCurrentlyActive ? 0.5 : 1.0)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color.theme.backgroundAccent)
		.overlay(isNewlySelected ? selectedBorder : nil)
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.padding(.horizontal)
    }
}

extension CardSelectable {
	
	private var selectedBorder: some View {
		RoundedRectangle(cornerRadius: 8)
			.stroke(Color.theme.textPrimary, lineWidth: 8)
	}
}
