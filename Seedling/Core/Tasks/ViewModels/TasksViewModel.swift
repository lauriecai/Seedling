//
//  TasksViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import CoreData
import Foundation

class TasksViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	// Tasks View
	@Published var taskCategories: [TaskCategory] = []
	
	// Add Task View
	@Published var taskTitleInput: String = ""
	
	// Category Selection View
	@Published var selectedCategory: TaskCategory? = nil
	@Published var selectedCategoryIndex: Int = 0
	
	@Published var showingActionSheet: Bool = false
	
	@Published var showingActionSheetForCategory: TaskCategory? = nil
	
	// Category Creation View
	@Published var taskCategoryInput: String = ""
	
	// Segues
	@Published var showingAddTaskView: Bool = false
	
	@Published var selectedTask: Task? = nil
	
	init() {
		if taskCategories.isEmpty {
			manager.addTaskCategory(name: "None")
			fetchTaskCategories()
		}
		
		selectedCategory = taskCategories.first(where: { $0.name == "None" })
	}
	
	//	MARK: - Task Category functions
	
	func fetchTaskCategories() {
		let request = manager.requestTaskCategories()
		
		do {
			var categories = try manager.context.fetch(request)
			if let noneCategoryIndex = categories.firstIndex(where: { $0.name == "None" }) {
				let noneCategory = categories.remove(at: noneCategoryIndex)
				
				categories.insert(noneCategory, at: 0)
			}
			
			taskCategories = categories
		} catch let error {
			print("Error fetching task categories from Core Data. \(error)")
		}
	}
	
	func addTaskCategory(name: String) {
		guard !name.isEmpty else { return }

		manager.addTaskCategory(name: name)
		fetchTaskCategories()
	}
	
	func updateTaskCategoryName(taskCategory: TaskCategory, name: String) {
		manager.updateTaskCategory(taskCategory: taskCategory, name: name)
		fetchTaskCategories()
	}
	
	func deleteTaskCategory(taskCategory: TaskCategory) {
		manager.deleteTaskCategory(taskCategory: taskCategory)
		fetchTaskCategories()
	}
	
	//	MARK: - Task functions
	
	func addTask(categoryName: String, title: String) {
		manager.addTask(categoryName: categoryName, title: title, isCompleted: false)
		resetTaskTitleAndCategoryNameInput()
		eraseCategoryNameInput()
		fetchTaskCategories()
	}
	
	func deleteTask(task: Task) {
		manager.deleteTask(task: task)
		fetchTaskCategories()
	}
	
	func resetTaskTitleAndCategoryNameInput() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.taskTitleInput = ""
			self.resetSelectedCategory()
			self.eraseCategoryNameInput()
		}
	}
	
	func resetSelectedCategory() {
		self.selectedCategory = taskCategories.first(where: { $0.name == "None" })
		self.selectedCategoryIndex = 0
	}
	
	func eraseCategoryNameInput() {
		self.taskCategoryInput = ""
	}
}

