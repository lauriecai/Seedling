//
//  TasksView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import SwiftUI

struct TasksView: View {
	
	@StateObject private var viewModel = TaskViewModel()
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			addTaskButton
		}
		.onAppear {
			viewModel.fetchTaskCategories()
		}
    }
}

#Preview {
    TasksView()
}

extension TasksView {
	
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
