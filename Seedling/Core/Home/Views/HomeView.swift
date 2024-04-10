//
//  HomeView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct HomeView: View {
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
//	@State private var selectedPlant: Plant? = nil
//	@State private var showingDetailView: Bool = false
//	@State private var showingAddPlantView: Bool = false
//	
//	@State private var showActionSheet: Bool = false
	
	init() {
		print("-----\nInitializing HomeView...")
		print("HomeView initialized!")
	}
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			VStack(alignment: .leading, spacing: 15) {
				dateHeader
				plantsList
			}
			.padding(.horizontal)
			
			addPlantButton
				.padding(.trailing, 20)
				.padding(.bottom, 25)
		}
		.navigationDestination(isPresented: $viewModel.showingDetailView) {
			DetailLoadingView(plant: $viewModel.selectedPlant)
		}
		.sheet(isPresented: $viewModel.showingAddPlantView) {
			AddPlantView()
		}
		.actionSheet(isPresented: $viewModel.showActionSheet) {
			ActionSheet(title: Text("Plant options"),
						buttons: [
							.destructive(Text("Delete plant")) {
								if let selectedPlant = viewModel.selectedPlant {
									withAnimation(Animation.easeInOut(duration: 0.4)) {
										viewModel.deletePlant(plant: selectedPlant)
										viewModel.fetchPlants()
									}
								}
							},
							.cancel()
						])
		}
		.onAppear { viewModel.fetchPlants() }
    }
}

#Preview {
    HomeView()
		.environmentObject(HomeViewModel())
}

// MARK: - UI

extension HomeView {
	
/// ``weather``
	
	private var dateHeader: some View {
		Text(Date().asDayAndDate())
			.font(.handjet(.extraBold, size: 32))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var weatherRow: some View {
		HStack(spacing: 10) {
			weatherCard
			weatherCard
			weatherCard
			weatherCard
			weatherCard
		}
	}
	
	private var weatherCard: some View {
		VStack(spacing: 5) {
			Text("Fri")
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textPrimary)
			
			Rectangle()
				.fill(Color.yellow)
				.frame(width: 40, height: 30)
			
			HStack {
				Text("77")
					.font(.handjet(.bold, size: 18))
					.foregroundStyle(Color.theme.textPrimary)
				Text("56")
					.font(.handjet(.regular, size: 18))
					.foregroundStyle(Color.theme.textPrimary)
			}
		}
		.padding(.vertical, 5)
		.padding(.horizontal, 10)
		.background(Color.theme.backgroundLight)
		.cornerRadius(8)
	}
	
/// ``plants list``
	
	private var plantsList: some View {
		ScrollView {
			ForEach(viewModel.plants, id: \.self.customHash) { plant in
				PlantCardView(plant: plant, showActionSheet: $viewModel.showActionSheet, showActionForPlant: $viewModel.selectedPlant)
					.onTapGesture { segue(plant: plant) }
			}
		}
	}
	
	private var addPlantButton: some View {
		ButtonCircle(icon: "icon-plus")
			.frame(width: 65, height: 65)
			.onTapGesture { viewModel.showingAddPlantView.toggle() }
	}
}

// MARK: - UI Functions

extension HomeView {
	
/// ``segueway into detail view``
	
	private func segue(plant: Plant) {
		viewModel.selectedPlant = plant
		viewModel.showingDetailView.toggle()
	}
}
