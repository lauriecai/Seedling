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
					VStack(alignment: .leading, spacing: 15) {
						taskTitleInput
						categorySelectionButton
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
			}
			.navigationTitle("New Task")
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(true)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) { cancelButton }
				ToolbarItem(placement: .topBarTrailing) { addTaskButton }
			}
		}
    }
}

#Preview {
    AddTaskView(viewModel: TasksViewModel())
}

extension AddTaskView {
	
//	MARK: - Add Task View
	
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
				viewModel.showingCategorySelectionView.toggle()
			}
		} label: {
			HStack {
				Text("Category")
					.font(.handjet(.bold, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				Spacer()
				
				HStack(spacing: 15) {
					Text(viewModel.taskCategoryInput)
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
			
			withAnimation(.spring()) {
				viewModel.addTask(categoryName: viewModel.taskCategoryInput, title: viewModel.taskTitleInput)
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
}
