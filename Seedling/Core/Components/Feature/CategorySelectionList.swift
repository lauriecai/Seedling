//
//  CategorySelectionList.swift
//  Seedling
//
//  Created by Laurie Cai on 5/28/24.
//

import SwiftUI

struct CategorySelectionList: View {
	
	let viewModel: TasksViewModel
	
	let categories: [TaskCategory]
	
	let accentTheme: Bool
	
	let selectedPillLabel: String
	@Binding var selectedCategory: TaskCategory?
	@Binding var selectedCategoryIndex: Int
	
    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 10) {
				ForEach(Array(categories.enumerated()), id: \.1) { index, category in
					CardSelectable(
						title: category.wrappedName,
						description: nil,
						accentTheme: accentTheme,
						isSelected: index == selectedCategoryIndex,
						selectedPillLabel: selectedPillLabel
					)
					.onTapGesture {
						withAnimation(.spring()) {
							selectedCategory = category
							selectedCategoryIndex = index
							viewModel.taskCategoryInput = category.wrappedName
							viewModel.showingAddTaskView.toggle()
						}
					}
				}
			}
		}
    }
}
