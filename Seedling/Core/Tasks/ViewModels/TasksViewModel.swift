//
//  TasksViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import CoreData
import Foundation

class TaskViewModel: ObservableObject {
	
	let manager = CoreDataManager.shared
	
	@Published var taskCategories: [TaskCategory] = []
	
	// Segues
	@Published var showingAddTaskView: Bool = false
	
//	MARK: - Task Category functions
	
	func fetchTaskCategories() {
		let request = manager.requestTaskCategories()
		
		do {
			taskCategories = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching tasks from Core Data. \(error)")
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
}
