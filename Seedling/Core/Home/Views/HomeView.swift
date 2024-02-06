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
			
			// navigation
			HStack {
				NavigationMenuItem(name: "Garden")
				Spacer()
				NavigationMenuItem(name: "Add Plant")
				Spacer()
				NavigationMenuItem(name: "To-do List")
			}
			.padding()
			.padding(.horizontal, 30)
			.padding(.bottom, 5)
			.background(Color.theme.backgroundDark)
			.frame(maxHeight: .infinity, alignment: .bottom)
			.ignoresSafeArea()
			
		}
    }
}

#Preview {
    HomeView()
		.environmentObject(HomeViewModel())
}

extension HomeView {
	
//	MARK: - Weather Row
	private var dateHeader: some View {
		Text("Wednesday, November 15")
			.font(.handjet(.extraBold, size: 32))
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
			
			Rectangle()
				.fill(Color.yellow)
				.frame(width: 40, height: 30)
			
			HStack {
				Text("77")
					.font(.handjet(.bold, size: 18))
				Text("56")
					.font(.handjet(.regular, size: 18))
			}
		}
		.padding(.vertical, 5)
		.padding(.horizontal, 10)
		.background(Color.theme.backgroundLight)
		.cornerRadius(8)
	}
	
//	MARK: - Plants List
	private var plantsList: some View {
		List {
			ForEach(viewModel.plants) { plant in
				PlantRowView(plant: plant)
			}
			.onDelete(perform: viewModel.deletePlant)
			.listRowInsets(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
			.listRowSeparator(.hidden)
			.listRowBackground(
				RoundedRectangle(cornerRadius: 8)
					.fill(Color.theme.backgroundLight)
					.padding(.vertical, 5)
			)
		}
		.listStyle(.plain)
		.scrollIndicators(.hidden)
	}
}
