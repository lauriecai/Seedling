//
//  TasksView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/21/24.
//

import SwiftUI

struct TasksView: View {
	
	@StateObject private var viewModel = TasksViewModel()
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			VStack(alignment: .leading, spacing: 20) {
				tasksHeader
				tasksList
			}
			.padding(.horizontal)
			
			addTaskButton
		}
		.onAppear { viewModel.fetchTaskCategories() }
		.sheet(isPresented: $viewModel.showingAddTaskView) {
			AddTaskView(viewModel: viewModel)
		}
		.confirmationDialog("Task Options", isPresented: $viewModel.showingActionSheet) {
			deleteTaskButton
		}
    }
}

#Preview {
    TasksView()
}

extension TasksView {
	
	private var tasksHeader: some View {
		Text("Tasks")
			.font(.handjet(.extraBold, size: 32))
			.foregroundStyle(Color.theme.textPrimary)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var tasksList: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 25) {
				ForEach(viewModel.taskCategories, id: \.customHash) { category in
					if !category.tasksList.isEmpty {
						TaskGroupView(
							category: category,
							viewModel: viewModel,
							showingActionSheet: $viewModel.showingActionSheet,
							selectedTask: $viewModel.selectedTask
						)
					}
				}
			}
			.padding(.bottom, 100)
		}
	}
	
	private var addTaskButton: some View {
		ButtonCircle(iconName: "icon-plus")
			.frame(width: 65, height: 65)
			.padding(.trailing, 20)
			.padding(.bottom, 25)
			.onTapGesture {
				UIImpactFeedbackGenerator(style: .light).impactOccurred()
				viewModel.showingAddTaskView.toggle()
			}
	}
	
	private var deleteTaskButton: some View {
		Button("Delete Task", role: .destructive) {
			if let selectedTask = viewModel.selectedTask {
				withAnimation(Animation.bouncy(duration: 0.25, extraBounce: 0.10)) {
					viewModel.deleteTask(task: selectedTask)
				}
			}
		}
	}
}
