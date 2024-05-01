//
//  StageCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct StageCardView: View {
	
	let stage: String
	let stageDefinition: String
	
	let isCurrentStage: Bool
	let isNewStage: Bool
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			HStack(spacing: 8) {
				Text(stage)
					.font(.handjet(.bold, size: 24))
				
				if isNewStage {
					Text("New Stage")
						.font(.handjet(.bold, size: 18))
						.padding(5)
						.padding(.horizontal, 3)
						.background(Color.theme.accentYellow)
						.clipShape(RoundedRectangle(cornerRadius: 4))
				}
			}
			
			Text(stageDefinition)
				.font(.handjet(.medium, size: 20))
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.border(Color.theme.textPrimary, width: 5)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
	StageCardView(
		stage: PlantStage.leafyGrowth.rawValue,
		stageDefinition: PlantStage.leafyGrowth.definition,
		isCurrentStage: false,
		isNewStage: true)
}
