//
//  DetailView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import SwiftUI

struct DetailLoadingView: View {
	
	@Binding var plant: Plant?
	
	init(plant: Binding<Plant?>) {
		self._plant = plant
		print("initializing detail view for :\(plant.wrappedValue?.wrappedName)")
	}
	
	var body: some View {
		Text(plant?.wrappedName ?? "")
	}
}

//struct DetailView: View {
//	
//	@StateObject private var viewModel: DetailViewModel
//	
//	init(plant: Plant) {
//		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
//	}
//	
//    var body: some View {
//		PlantRowView(plant: viewModel.plant)
//    }
//}
