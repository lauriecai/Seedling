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
			
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 20) {
					Text("Tasks")
						.font(.handjet(.extraBold, size: 32))
						.foregroundStyle(Color.theme.textPrimary)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.horizontal)
					
					tasksList
				}
			}
			
			addTaskButton
		}
		.onAppear { viewModel.fetchTasks() }
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
	
	private var tasksList: some View {
		VStack(alignment: .leading, spacing: 12) {
			ForEach(viewModel.tasks.dropLast()) { task in
				TaskRowView(
					task: task,
					showActionSheet: $viewModel.showingActionSheet,
					showActionForTask: $viewModel.selectedTask
				)
				.onTapGesture { toggleTaskCompletion(task: task) }
				
				Divider()
					.padding(.leading, 20)
			}
			
			if let lastTask = viewModel.tasks.last {
				TaskRowView(
					task: lastTask,
					showActionSheet: $viewModel.showingActionSheet,
					showActionForTask: $viewModel.selectedTask
				)
					.onTapGesture { toggleTaskCompletion(task: lastTask) }
			}
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
	
	private func toggleTaskCompletion(task: Task) {
		UIImpactFeedbackGenerator(style: .light).impactOccurred()
		task.isCompleted.toggle()
		viewModel.fetchTasks()
	}
}
