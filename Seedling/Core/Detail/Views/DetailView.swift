//
//  DetailView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import SwiftUI

struct DetailView: View {
	
	@StateObject private var viewModel: DetailViewModel
	
	init(plant: Plant) {
		_viewModel = StateObject(wrappedValue: DetailViewModel(plant: plant))
	}
	
    var body: some View {
		PlantRowView(plant: viewModel.plant)
    }
}
