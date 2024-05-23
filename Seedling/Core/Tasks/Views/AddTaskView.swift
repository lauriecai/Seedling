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
						if viewModel.showingTaskCategorySelectionView {
							categorySelectionView
								.transition(.move(edge: .trailing))
								.padding(.horizontal)
						} else {
							addTaskView
								.transition(.move(edge: .leading))
								.padding(.horizontal)
						}
					}
				}
			}
			.navigationTitle("New Task")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { cancelButton }
				ToolbarItem(placement: .topBarTrailing) {
					// figure out logic here
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
				viewModel.showingTaskCategorySelectionView.toggle()
			}
		} label: {
			HStack {
				Text("Category")
					.font(.handjet(.bold, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
				
				HStack(spacing: 15) {
					Text(viewModel.taskCategoryInput?.wrappedName ?? "None")
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
	
	struct selectedCategory: View {
		
		let categoryName: String
		
		var body: some View {
			Text(categoryName)
				.font(.handjet(.medium, size: 20))
		}
	}
	
	private var addTaskButton: some View {
		Button("Add Task") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
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
			viewModel.resetTaskTitleInput()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
	
//	MARK: - Category Selection View
	
	private var categorySelectionView: some View {
		VStack(spacing: 15) {
			Text("Select a category:")
				.font(.handjet(.extraBold, size: 22))
				.foregroundStyle(Color.theme.textPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			ForEach(viewModel.taskCategories) { category in
				CardSelectable(title: category.wrappedName, accentTheme: true, isSelected: false)
					.onTapGesture {
						withAnimation(.spring()) {
							viewModel.showingTaskCategorySelectionView.toggle()
						}
					}
			}
		}
		.onTapGesture {
			withAnimation(.spring()) {
				viewModel.showingTaskCategorySelectionView.toggle()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	
	private var newCategoryButton: some View {
		Button("New Category") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			
			withAnimation(.spring()) {
				viewModel.showingTaskCategoryCreationView = true
			}
		}
	}
}
