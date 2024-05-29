//
//  TaskGroupView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/28/24.
//

import SwiftUI

struct TaskGroupView: View {
	
	let category: TaskCategory
	let viewModel: TasksViewModel
	
	@Binding var showingActionSheet: Bool
	@Binding var selectedTask: Task?
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
				Text(category.wrappedName)
					.font(.handjet(.extraBold, size: 26))
			
			VStack(alignment: .leading, spacing: 10) {
				ForEach(category.tasksList, id: \.customHash) { task in
					TaskRowView(
						task: task,
						showActionSheet: $showingActionSheet,
						showActionForTask: $selectedTask
					)
					.onTapGesture {
						UIImpactFeedbackGenerator(style: .light).impactOccurred()
						print("tapped - \(task.wrappedTitle)")
						print("isCompleted - \(task.isCompleted)")
						task.isCompleted.toggle()
						viewModel.fetchTaskCategories()
						print("after toggle - \(task.isCompleted)\n-----")
					}
					
					if task != category.tasksList.last {
						Divider()
					}
				}
			}
		}
	}
}
