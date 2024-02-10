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
	
    var body: some View {
		ZStack {
			// background
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			// content
			VStack(alignment: .leading, spacing: 15) {
				weatherRow
				dateHeader
				plantsList
			}
			.padding(.horizontal)
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
		
    }
}

#Preview {
    HomeView()
		.environmentObject(HomeViewModel())
}

// MARK: - Condensed UI
extension HomeView {
	
//	weather
	private var dateHeader: some View {
		Text("\(Date().withDayAndDate())")
			.font(.handjet(.extraBold, size: 32))
			.foregroundStyle(Color.theme.textPrimary)
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
	
//	plants list
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
				}
			}
		}
	}
}

// MARK: - UI Functions
extension HomeView {
	
//	card drag behavior
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
