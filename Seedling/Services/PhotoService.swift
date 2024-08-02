//
//  PhotoService.swift
//  Seedling
//
//  Created by Laurie Cai on 6/27/24.
//

import CoreData
import Foundation

// MARK: - Description
// Responsible for photo CRUD operations

class PhotoService {
	
	private let coreDataManager = CoreDataManager.shared
	
//	MARK: - Public Methods
	
	func fetchPhotos() -> [Photo] {
		let request = createPhotoRequest()
		
		do {
			return try coreDataManager.context.fetch(request)
		} catch {
			print("Error fetching images. \(error.localizedDescription)")
			return []
		}
	}
	
	func createPhoto(caption: String) -> Photo {
		let newPhoto = Photo(context: coreDataManager.context)
		newPhoto.imageUrlString = UUID().uuidString
		newPhoto.timestamp = Date()
		newPhoto.caption = ""
		
		return newPhoto
	}
	
//	MARK: - Private Methods
	
	private func createPhotoRequest() -> NSFetchRequest<Photo> {
		let request = NSFetchRequest<Photo>(entityName: "Photo")
		
		return request
	}
}
