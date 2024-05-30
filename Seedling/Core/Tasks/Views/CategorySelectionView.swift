//
//  CategorySelectionView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/29/24.
//

import SwiftUI

struct CategorySelectionView: View {
	
	@ObservedObject var viewModel: TasksViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				VStack(spacing: 10) {
					Text("Select a category:")
						.font(.handjet(.extraBold, size: 22))
						.foregroundStyle(Color.theme.textPrimary)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					CategorySelectionList(
						viewModel: viewModel,
						categories: viewModel.taskCategories,
						accentTheme: true,
						selectedPillLabel: "Selected",
						selectedCategory: $viewModel.selectedCategory,
						selectedCategoryIndex: $viewModel.selectedCategoryIndex)
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle("Category")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
			ToolbarItem(placement: .topBarTrailing) { newCategoryButton }
		}
		.onAppear {
			viewModel.fetchTaskCategories()
		}
    }
}

#Preview {
	CategorySelectionView(viewModel: TasksViewModel())
}

extension CategorySelectionView {
	
	private var newCategoryButton: some View {
		Button("New Category") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			withAnimation(.spring()) {
				viewModel.eraseCategoryNameInput()
				viewModel.showingCategoryCreationView.toggle()
			}
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
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
