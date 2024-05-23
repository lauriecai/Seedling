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
    }
}

#Preview {
    TasksView()
}

extension TasksView {
	
	private var tasksList: some View {
		VStack(alignment: .leading, spacing: 10) {
			ForEach(viewModel.tasks.dropLast()) { task in
				TaskRowView(taskTitle: task.wrappedTitle, isComplete: task.isCompleted)
					.onTapGesture {
						UIImpactFeedbackGenerator(style: .light).impactOccurred()
						task.isCompleted.toggle()
						viewModel.fetchTasks()
					}
				Divider()
					.padding(.leading, 20)
			}
			
			if let lastTask = viewModel.tasks.last {
				TaskRowView(taskTitle: lastTask.wrappedTitle, isComplete: lastTask.isCompleted)
					.onTapGesture {
						UIImpactFeedbackGenerator(style: .light).impactOccurred()
						lastTask.isCompleted.toggle()
						viewModel.fetchTasks()
					}
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
}
