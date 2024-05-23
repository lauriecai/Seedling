//
//  TaskRowView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/22/24.
//

import SwiftUI

struct TaskRowView: View {
	
	let task: Task

	@Binding var showActionSheet: Bool
	@Binding var showActionForTask: Task?
	
    var body: some View {
		HStack(alignment: .top) {
			taskItem
			Spacer()
			taskActions
		}
		.background(Color.theme.backgroundPrimary)
		.padding(.horizontal, 20)
    }
}

extension TaskRowView {
	
	private var taskItem: some View {
		HStack(alignment: .top, spacing: 12) {
			if task.isCompleted { checkedBox } else { uncheckedBox }
			
			Text(task.wrappedTitle)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
				.strikethrough(task.isCompleted ? true : false)
				.opacity(task.isCompleted ? 0.40 : 1.0)
		}
	}
	
	private var uncheckedBox: some View {
		RoundedRectangle(cornerRadius: 4)
			.frame(width: 25, height: 25)
			.foregroundStyle(Color.theme.backgroundAccent)
	}
	
	private var checkedBox: some View {
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: 4)
				.frame(width: 25, height: 25)
				.foregroundStyle(Color.theme.backgroundAccent)
			
			Image("icon-checkmark")
				.frame(width: 10, height: 9)
				.foregroundStyle(Color.theme.textPrimary)
		}
		.opacity(0.40)
	}
	
	private var taskActions: some View {
		Button {
			showActionSheet = true
			showActionForTask = task
		} label: {
			MenuKebab()
				.frame(maxHeight: .infinity)
				.rotationEffect(.degrees(-90))
		}
	}
}
