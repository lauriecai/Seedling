//
//  UpdateStageView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct UpdateStageView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
	init(viewModel: DetailViewModel) {
		self.viewModel = viewModel
	}
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			VStack {
				updateStagePrompt

				StageSelectionList(
					items: PlantStage.allCases,
					accentTheme: true,
					selectedPillLabel: "Selected",
					selectedItem: $viewModel.selectedStage,
					selectedItemIndex: $viewModel.selectedStageIndex
				)
			}
			.padding()
		}
		.navigationTitle("Update Stage")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.onAppear {
			CrashManager.shared.addLog(message: "UpdateStageView appeared.")
			viewModel.fetchPlantStage(for: viewModel.plant)
		}
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { cancelButton }
			ToolbarItem(placement: .topBarTrailing) { saveChangesButton }
		}
		.onChange(of: viewModel.selectedStage) { viewModel.plantStageUpdated = true }
    }
}

extension UpdateStageView {
	
	private var updateStagePrompt: some View {
		Text("Select a new stage:")
			.font(.handjet(.extraBold, size: 22))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			CrashManager.shared.addLog(message: "saveChangesButton tapped.")
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			if viewModel.plantStageUpdated {
				viewModel.updatePlantStage(for: viewModel.plant)
			}
			viewModel.resetStageUpdatedFlag()
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.plantStageUpdated ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.plantStageUpdated)
	}
	
	private var cancelButton: some View {
		Button {
			CrashManager.shared.addLog(message: "cancelButton tapped.")
			viewModel.resetStageUpdatedFlag()
			dismiss()
		} label: {
			Text("Cancel")
				.font(.handjet(.medium, size: 20))
				.foregroundStyle(Color.theme.textSecondary)
		}
	}
}
