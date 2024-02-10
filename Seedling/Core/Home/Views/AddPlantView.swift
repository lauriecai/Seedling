//
//  AddPlantView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/9/24.
//

import SwiftUI

struct AddPlantView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@State private var name = ""
	@State private var variety = ""
	@State private var stage = "Seed"
	@State private var type = "Vegetable"
	
	let stages = ["Seed", "Germinated", "Seedling", "Bulb", "Transplant"]
	let types = ["Vegetable", "Fruit", "Herb", "Flower"]
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Name of plant", text: $name)
					TextField("Variety", text: $variety)
					
					Picker("Stage", selection: $stage) {
						ForEach(stages, id: \.self) {
							Text($0)
						}
					}
					
					Picker("Type", selection: $type) {
						ForEach(types, id: \.self) {
							Text($0)
						}
					}
				}
				
				Section {
					Button("Save") {
						viewModel.addPlant(type: type, name: name, variety: variety, stage: stage)
					}
				}
			}
		}
    }
}

#Preview {
    AddPlantView()
}
