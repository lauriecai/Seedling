//
//  AddPlantView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/9/24.
//

import SwiftUI

struct AddPlantView: View {
	
	@EnvironmentObject private var viewModel: HomeViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State private var name = ""
	@State private var variety = ""
	@State private var stage = "Seed"
	@State private var type = "Vegetable"
	
	let stages = ["Seed", "Seedling", "Bulb", "Transplant"]
	let types = ["Vegetable", "Fruit", "Herb", "Flower"]
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView {
				VStack(spacing: 20) {
					plantTextInput
					plantVarietyInput
					saveButton
				}
				.padding()
			}
			.navigationTitle("Add Plant")
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					HStack(spacing: 5) {
						Image(systemName: "chevron.left")
							.font(.handjet(.medium, size: 18))
						Text("Back")
							.font(.handjet(.bold, size: 20))
					}
					.foregroundStyle(Color.theme.accentGreen)
					.onTapGesture { dismiss() }
				}
			}
		}
	}
}

#Preview {
    AddPlantView()
}

extension AddPlantView {
	
	private var plantTextInput: some View {
		VStack(alignment: .leading, spacing: 10) {
			ZStack(alignment: .leading) {
				if name.isEmpty {
					Text("What's your plant called?")
						.padding()
						.foregroundStyle(Color.theme.textSecondary)
				}
				
				TextField("", text: $name)
					.foregroundStyle(Color.theme.textPrimary)
					.padding()
			}
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.theme.backgroundAccent, lineWidth: 3)
			)
		}
		.font(.handjet(.bold, size: 22))
	}
	
	private var plantVarietyInput: some View {
		VStack(alignment: .leading, spacing: 10) {
			ZStack(alignment: .leading) {
				if name.isEmpty {
					Text("What variety is it?")
						.padding()
						.foregroundStyle(Color.theme.textSecondary)
				}
				
				TextField("", text: $variety)
					.foregroundStyle(Color.theme.textPrimary)
					.padding()
			}
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(Color.theme.backgroundAccent, lineWidth: 3)
			)
		}
		.font(.handjet(.bold, size: 22))
	}
	
	private var saveButton: some View {
		Button("Save") {
			viewModel.addPlant(
				type: type,
				name: name,
				variety: variety,
				stage: stage
			)
			dismiss()
		}
	}
}
