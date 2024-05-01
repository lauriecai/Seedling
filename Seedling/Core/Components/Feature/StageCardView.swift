//
//  StageCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct StageCardView: View {
	
	let stageName: String
	let stageDefinition: String
	
	let isCurrentStage: Bool
	let isNewStage: Bool
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			HStack(spacing: 8) {
				stageHeader
					.opacity(isCurrentStage ? 0.5 : 1.0)
				
				if isCurrentStage { currentStagePill }
				if isNewStage { newStagePill }
			}
			
			definitionBody
				.opacity(isCurrentStage ? 0.5 : 1.0)
		}
		.padding()
		.background(Color.theme.backgroundAccent.opacity(isCurrentStage ? 0.5 : 1.0))
		.overlay(isNewStage ? selectedBorder : nil)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension StageCardView {
	
	private var stageHeader: some View {
		Text(stageName)
			.font(.handjet(.bold, size: 24))
	}
	
	private var definitionBody: some View {
		Text(stageDefinition)
			.font(.handjet(.medium, size: 20))
	}
	
	private var currentStagePill: some View {
		TextPill(label: "Current Stage", backgroundColor: Color.theme.backgroundLight)
	}
	
	private var newStagePill: some View {
		TextPill(label: "New Stage", backgroundColor: Color.theme.accentYellow)
	}
	
	private var selectedBorder: some View {
		RoundedRectangle(cornerRadius: 8)
			.stroke(Color.theme.textPrimary, lineWidth: 8)
	}
}

#Preview {
	StageCardView(
		stageName: PlantStage.leafyGrowth.rawValue,
		stageDefinition: PlantStage.leafyGrowth.definition,
		isCurrentStage: true,
		isNewStage: false)
}
