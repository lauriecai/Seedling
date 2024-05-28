//
//  AddTaskView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/20/24.
//

import SwiftUI

struct AddTaskView: View {
	
	@ObservedObject var viewModel: TasksViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		NavigationStack {
			ZStack {
				Color.theme.backgroundPrimary
					.ignoresSafeArea()
				
				ScrollView(showsIndicators: false) {
					VStack {
						if viewModel.selectedAddTaskViewIndex == 0 {
							addTaskView
						} else if viewModel.selectedAddTaskViewIndex == 1 {
							categorySelectionView
						} else if viewModel.selectedAddTaskViewIndex == 2 {
							categoryCreationView
						}
					}
					.padding(.horizontal)
				}
			}
			.navigationTitle(viewModel.selectedAddTaskViewIndex == 2 ?
							 "New Category" : viewModel.selectedAddTaskViewIndex == 1 ?
							 "Category" : "New Task")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { cancelButton }
				ToolbarItem(placement: .topBarTrailing) {
					if viewModel.selectedAddTaskViewIndex == 0 {
						addTaskButton
					} else if viewModel.selectedAddTaskViewIndex == 1 {
						newCategoryButton
					} else if viewModel.selectedAddTaskViewIndex == 2 {
						createButton
					}
				}
			}
		}
    }
}

#Preview {
    AddTaskView(viewModel: TasksViewModel())
}

extension AddTaskView {
	
//	MARK: - Add Task View
	
	private var addTaskView: some View {
		VStack(alignment: .leading, spacing: 15) {
			taskTitleInput
			categorySelectionButton
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	
	private var taskTitleInput: some View {
		TextEditorInput(
			inputHeader: "Task Description",
			inputPlaceholder: "e.g. Fertilize tomatoes",
			accentTheme: true,
			text: $viewModel.taskTitleInput
		)
	}
	
	private var categorySelectionButton: some View {
		Button {
			withAnimation(.spring()) {
				viewModel.selectedAddTaskViewIndex = 1
			}
		} label: {
			HStack {
				Text("Category")
					.font(.handjet(.bold, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
				
				HStack(spacing: 15) {
					Text("None")
						.font(.handjet(.medium, size: 20))
					
					Text(">")
						.font(.handjet(.bold, size: 22))
				}
				.foregroundStyle(Color.theme.textSecondary)
			}
			.padding()
			.background(Color.theme.backgroundAccent)
			.clipShape(RoundedRectangle(cornerRadius: 8))
		}
	}
	
	private var addTaskButton: some View {
		Button("Add Task") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			// create a category using user's selection or newly entered text
			
			// assign that category to view model taskCategoryInput
				
			// add task into that category
			withAnimation(.spring()) {
				viewModel.addTask(category: nil, title: viewModel.taskTitleInput)
			}
			
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.taskTitleInput.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.taskTitleInput.isEmpty)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			dismiss()
			viewModel.resetTaskInputsAndFlags()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
	
	struct selectedCategory: View {
		
		let categoryName: String
		
		var body: some View {
			Text(categoryName)
				.font(.handjet(.medium, size: 20))
		}
	}
	
//	MARK: - Category Selection View
	
	private var categorySelectionView: some View {
		VStack(spacing: 10) {
			Text("Select a category:")
				.font(.handjet(.extraBold, size: 22))
				.foregroundStyle(Color.theme.textPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			ForEach(viewModel.taskCategories) { category in
				CardSelectable(title: category.wrappedName, accentTheme: true, isSelected: false)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.onAppear {
			viewModel.fetchTaskCategories()
		}
	}
	
	private var newCategoryButton: some View {
		Button("New Category") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			withAnimation(.spring()) {
				viewModel.selectedAddTaskViewIndex = 2
			}
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
//	MARK: - Category Creation View
	
	private var categoryCreationView: some View {
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
	
	private var createButton: some View {
		Button("Create") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			viewModel.addTaskCategory(name: viewModel.taskCategoryInput)
			
			withAnimation(.spring()) {
				viewModel.selectedAddTaskViewIndex = 1
			}
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.taskCategoryInput.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.taskCategoryInput.isEmpty)
	}
}
