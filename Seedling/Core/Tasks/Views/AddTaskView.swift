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
						TextEditorInput(
							inputHeader: "Task Description",
							inputPlaceholder: "e.g. Fertilize tomatoes",
							accentTheme: true,
							text: $viewModel.taskTitleInput)
					}
					.padding()
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
	
	private var addTaskButton: some View {
		Button("Add Task") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			viewModel.addTask(category: nil, title: viewModel.taskTitleInput)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.taskTitleInput.isEmpty ? Color.theme.textSecondary.opacity(0.5) : Color.theme.accentGreen)
		.disabled(viewModel.taskTitleInput.isEmpty)
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			print("Cancelled!")
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
