//
//  TaskCategorySelectionView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/23/24.
//

import SwiftUI

struct TaskCategorySelectionView: View {
	
	@ObservedObject var viewModel: TasksViewModel
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				VStack(spacing: 15) {
					Text("Hi")
					Text("hellooooo")
				}
			}
		}
		.navigationTitle("Category")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { backButton }
			ToolbarItem(placement: .topBarTrailing) { newCategoryButton }
		}
    }
}

#Preview {
	TaskCategorySelectionView(viewModel: TasksViewModel())
}

extension TaskCategorySelectionView {
	
	private var backButton: some View {
		Button {
			dismiss()
		} label: {
			HStack(spacing: 5) {
				Image(systemName: "chevron.left")
					.font(.handjet(.medium, size: 18))
				Text("Back")
					.font(.handjet(.medium, size: 20))
			}
			.foregroundStyle(Color.theme.textSecondary)
		}
	}
	
	private var newCategoryButton: some View {
		Text("New Category")
	}
}
