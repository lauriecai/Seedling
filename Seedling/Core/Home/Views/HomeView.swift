//
//  HomeView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct HomeView: View {
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	var body: some View {
		NavigationStack {
			ZStack(alignment: .bottomTrailing) {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				VStack(alignment: .leading, spacing: 15) {
					dateHeader
					plantsList
				}
				.padding(.horizontal)
				
				addPlantButton
			}
			.navigationDestination(for: Plant.self) { plant in
				DetailView(plant: plant)
			}
			.sheet(isPresented: $viewModel.showingAddPlantView) { AddPlantView() }
			.confirmationDialog("Plant Options", isPresented: $viewModel.showingActionSheet) {
				editPlantNameButton
				deletePlantButton
			} message: {
				Text("What do you want to do with this plant?")
			}
			.onAppear {
				viewModel.fetchPlants()
			}
		}
    }
}

#Preview {
    HomeView()
		.environmentObject(HomeViewModel())
}

// MARK: - UI

extension HomeView {
	
	private var dateHeader: some View {
		Text(Date().asDayAndDate())
			.font(.handjet(.extraBold, size: 32))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var plantsList: some View {
		ScrollView(showsIndicators: false) {
			VStack {
				ForEach(viewModel.plants, id: \.self.customHash) { plant in
					NavigationLink(value: plant) {
						PlantCardView(
							plant: plant,
							showActionSheet: $viewModel.showingActionSheet,
							showActionForPlant: $viewModel.selectedPlant
						)
					}
				}
			}
			.padding(.bottom, 100)
		}
	}
	
	private var addPlantButton: some View {
		ButtonCircle(iconName: "icon-plus")
			.frame(width: 65, height: 65)
			.padding(.trailing, 20)
			.padding(.bottom, 25)
			.onTapGesture {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				viewModel.showingAddPlantView.toggle()
			}
	}
	
	private var editPlantNameButton: some View {
		Button("Edit Name and Variety") {
			viewModel.resetPlantDetailsChangedFlag()
			
			if let selectedPlant = viewModel.selectedPlant {
				viewModel.editingExistingPlant = true
				viewModel.showingAddPlantView = true
				viewModel.fetchExistingPlantNameAndVariety(for: selectedPlant)
			}
		}
	}
	
	private var deletePlantButton: some View {
		Button("Delete Plant", role: .destructive) {
			if let selectedPlant = viewModel.selectedPlant {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
					viewModel.deletePlant(plant: selectedPlant)
				}
			}
		}
	}
}
