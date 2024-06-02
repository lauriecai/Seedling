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
	
	@State private var showingActionSheet: Bool = false
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView(showsIndicators: false) {
					VStack(spacing: 10) {
						selectionPrompt
						categorySelectionList
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
			.confirmationDialog("Category Options", isPresented: $showingActionSheet) {
				editCategoryButton
				deleteCategoryButton
			} message: {
				Text("What do you want to do with this category?")
			}
			.onAppear {
				viewModel.fetchTaskCategories()
			}
		}
    }
}

#Preview {
	CategorySelectionView(viewModel: TasksViewModel())
}

extension CategorySelectionView {
	
	private var selectionPrompt: some View {
		Text("Select a category:")
			.font(.handjet(.extraBold, size: 22))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var categorySelectionList: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 10) {
				ForEach(Array(viewModel.taskCategories.enumerated()), id: \.1) { index, category in
//					CardSelectable(
//						title: category.wrappedName,
//						accentTheme: true,
//						isSelected: index == viewModel.selectedCategoryIndex,
//						isActionable: category.wrappedName == "None" ? false : true,
//						showActionSheet: $showingActionSheet,
//						showActionSheetForCategory:
//					)
					CategorySelectionCard(
						category: category,
						isSelected: index == viewModel.selectedCategoryIndex,
						showActionSheet: $showingActionSheet,
						showActionForCategory: $viewModel.showingActionSheetForCategory)
					.onTapGesture {
						withAnimation(.spring()) {
							viewModel.selectedCategory = category
							viewModel.selectedCategoryIndex = index
							viewModel.taskCategoryInput = category.wrappedName
							dismiss()
						}
						print("Card tapped")
					}
				}
			}
		}
	}
	
	private var newCategoryButton: some View {
		NavigationLink(destination: CategoryCreationView(viewModel: viewModel)) {
			Text("New Category")
				.font(.handjet(.extraBold, size: 20))
				.foregroundStyle(Color.theme.accentGreen)
		}
	}
	
	private var editCategoryButton: some View {
		Button("Edit Category") {
			print("Edit tapped")
		}
	}
	
	private var deleteCategoryButton: some View {
		Button("Delete Category", role: .destructive) {
			guard let selectedCategory = viewModel.showingActionSheetForCategory else {
				print("no selected category set")
				return
			}
			withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
				viewModel.deleteTaskCategory(taskCategory: selectedCategory)
			}
		}
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
