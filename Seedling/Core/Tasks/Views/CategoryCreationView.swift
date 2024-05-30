//
//  CategoryCreationView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/29/24.
//

import SwiftUI

struct CategoryCreationView: View {
	
	@ObservedObject var viewModel: TasksViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				VStack(spacing: 15) {
					TextInput(
						inputHeader: "Category Name",
						inputPlaceholder: "e.g. Wishlist",
						headerDescription: nil,
						text: $viewModel.taskCategoryInput
					)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			.navigationTitle("New Category")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { backButton }
				ToolbarItem(placement: .topBarTrailing) { createButton }
			}
		}
    }
}

#Preview {
	CategoryCreationView(viewModel: TasksViewModel())
}

extension CategoryCreationView {
	
	private var createButton: some View {
		Button("Create") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			viewModel.addTaskCategory(name: viewModel.taskCategoryInput)
			
			withAnimation(.spring()) {
				viewModel.showingCategoryCreationView.toggle()
			}
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.taskCategoryInput.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.taskCategoryInput.isEmpty)
	}
	
	private var backButton: some View {
		Button {
			dismiss()
		} label: {
			HStack(spacing: 5) {
				Image(systemName: "chevron.left")
					.font(.handjet(.medium, size: 18))
				Text("Back")
					.font(.handjet(.medium, size: 20))
			}
			.foregroundStyle(Color.theme.textSecondary)
		}
	}
}
