//
//  PlantDetailsView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/9/24.
//

import SwiftUI

struct PlantDetailsLoadingView: View {
	
	let viewModel: DetailViewModel
	
	var body: some View {
		PlantDetailsView(viewModel: viewModel)
	}
}

struct PlantDetailsView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			Text("Plant Details includes general info and care instructions.")
				.font(.handjet(.extraBold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
		}
    }
}
