//
//  TaskRowView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/22/24.
//

import SwiftUI

struct TaskRowView: View {
	
	let taskTitle: String
	let isComplete: Bool
	
    var body: some View {
		HStack(spacing: 12) {
			if isComplete { checkedBox } else { checkbox }
			
			Text(taskTitle)
				.font(.handjet(.bold, size: 20))
				.strikethrough(isComplete ? true : false)
				.opacity(isComplete ? 0.40 : 1.0)
			
			Spacer()
			
			MenuKebab()
				.frame(maxHeight: .infinity)
				.rotationEffect(.degrees(-90))
		}
		.padding(.horizontal, 20)
    }
}

#Preview {
	ZStack {
		Color.theme.backgroundPrimary
			.ignoresSafeArea()
		
		TaskRowView(taskTitle: "Fertilize tomatoes", isComplete: true)
	}
}

extension TaskRowView {
	
	private var checkbox: some View {
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
}
