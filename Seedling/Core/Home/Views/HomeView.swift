//
//  HomeView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct HomeView: View {
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@GestureState private var dragDistance = CGSize.zero
	
	@State private var selectedPlant: Plant? = nil
	@State private var showingDetailView = false
	@State private var showingAddPlantView = false
	
	init() {
		print("Initializing HomeView...")
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
		.gesture(
			TapGesture().onEnded({ _ in
				withAnimation(Animation.spring(Spring(duration: 0.2))) {
					viewModel.resetOffsets()
				}
			})
		)
		.gesture(
			DragGesture().onChanged({ _ in
				withAnimation(Animation.spring(Spring(duration: 0.2))) {
					viewModel.resetOffsets()
				}
			})
		)
		.navigationDestination(isPresented: $showingDetailView) {
			DetailLoadingView(plant: $selectedPlant)
		}
		.sheet(isPresented: $showingAddPlantView) {
			AddPlantView()
		}
    }
}

#Preview {
    HomeView()
		.environmentObject(HomeViewModel())
}

// MARK: - Condensed UI
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
			ForEach(viewModel.plants) { plant in
				ZStack {
					Color.theme.accentRed
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.onTapGesture {
							withAnimation(Animation.easeInOut(duration: 0.4)) {
								viewModel.deletePlant(plant: plant)
							}
						}
						
					
					HStack {
						Spacer()
						Text("Delete")
							.font(.handjet(.bold, size: 18))
							.foregroundStyle(Color.white)
							.padding()
					}
					
					PlantRowView(plant: plant)
						.offset(x: CGFloat(plant.offset))
						.gesture(
							DragGesture()
								.updating($dragDistance, body: { value, state, _ in
									state = value.translation
									onDragChange(plant: plant, value: value)
								})
								.onEnded({ value in
									onDragEnd(plant: plant, value: value)
								})
						)
						.onTapGesture { segue(plant: plant) }
				}
			}
		}
	}
	
/// ``actions``
	private var addPlantButton: some View {
		ButtonCircle(icon: "icon-plus")
			.frame(width: 65, height: 65)
			.onTapGesture { showingAddPlantView.toggle() }
	}
}

// MARK: - UI Functions
extension HomeView {
	
/// ``segueway into detail view``
	private func segue(plant: Plant) {
		selectedPlant = plant
		showingDetailView.toggle()
	}
	
/// ``card drag behavior``
	private func onDragChange(plant: Plant, value: DragGesture.Value) {
		if value.translation.width < 0 {
			DispatchQueue.main.async {
				withAnimation(Animation.spring(Spring(duration: 0.2))) {
					viewModel.resetOffsets()
					plant.offset = Float(value.translation.width)
				}
				
				viewModel.save()
			}
		}
	}
	
	private func onDragEnd(plant: Plant, value: DragGesture.Value) {
		if -value.translation.width >= 70 {
			withAnimation(Animation.spring) {
				plant.offset = -70
				viewModel.save()
			}
		} else {
			withAnimation(Animation.spring(Spring(duration: 0.2))) {
				plant.offset = 0
				viewModel.save()
			}
		}
	}
}
