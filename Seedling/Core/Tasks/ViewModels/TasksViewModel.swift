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
	
	// Add Task View / Category Creation View
	@Published var taskTitleInput: String = ""
	@Published var taskCategoryInput: String = "None"
	
	// Category Selection View
	@Published var selectedCategory: TaskCategory? = nil
	@Published var selectedCategoryIndex: Int = 0
	
	// Segues
	@Published var showingAddTaskView: Bool = false
	@Published var showingCategorySelectionView: Bool = false
	@Published var showingCategoryCreationView: Bool = false
	
	@Published var selectedTask: Task? = nil
	@Published var showingActionSheet: Bool = false
	
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
		resetTaskInputsAndFlags()
		eraseCategoryNameInput()
		fetchTaskCategories()
	}
	
	func deleteTask(task: Task) {
		manager.deleteTask(task: task)
		fetchTaskCategories()
	}
	
	func resetTaskInputsAndFlags() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.taskTitleInput = ""
			self.taskCategoryInput = "None"
		}
	}
	
	func eraseCategoryNameInput() {
		self.taskCategoryInput = ""
	}
}
