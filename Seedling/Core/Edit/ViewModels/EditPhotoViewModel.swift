//
//  EditPhotoViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 7/2/24.
//

import Foundation
import SwiftUI

class EditPhotoViewModel: ObservableObject {
	
	@Published var image: UIImage
	@Published var caption: String = ""
	
	var imageUrlString: String?
	var editingExistingImage: Bool { imageUrlString != nil }
	
	let coreDataManager = CoreDataManager.shared
	let fileManager = FileManager()
	
	let photoService = PhotoService()
	
//	MARK: - Init
	
	init(newImage: UIImage) {
		self.image = newImage
	}
	
	init(existingPhoto: Photo) {
		self.image = existingPhoto.uiImage
		self.caption = existingPhoto.wrappedCaption
		self.imageUrlString = existingPhoto.wrappedImageUrlString
	}
	
//	MARK: - Public Methods
	
	func createPhoto() {
		let newPhoto = photoService.createPhoto(caption: caption)
		
		coreDataManager.save()
		fileManager.saveImage(id: newPhoto.wrappedImageUrlString, image: image)
	}
	
//	func saveChanges(for plant: Plant) {
//		guard let imageUrlString,
//			  let savedPhoto = findExistingPhoto(for: plant) else { return }
//		
//		savedPhoto.caption = caption
//		
//		coreDataManager.save()
//		fileManager.saveImage(id: imageUrlString, image: image)
//	}
//	
//	func deletePhoto() {
//		guard let imageUrlString,
//			  let savedPhoto = findExistingPhoto(for: plant) else { return }
//		
//		fileManager.deleteImage(id: imageUrlString)
//		coreDataManager.deletePhoto(photo: savedPhoto)
//	}
	
//	MARK: - Private Methods
	
//	private func fetchPhotos(for plant: Plant) -> [Photo]? {
//		photoService.fetchPhotos(for: plant)
//	}
//	
//	private func findExistingPhoto(for plant: Plant) -> Photo? {
//		let allPhotos = fetchPhotos(for: plant)
//		
//		if let existingPhoto = allPhotos?.first(where: { $0.imageUrlString == imageUrlString })
//		{ return existingPhoto } else { return nil }
//	}
}
