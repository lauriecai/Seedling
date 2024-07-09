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
	
	init(existingImage: Photo) {
		self.image = existingImage.uiImage
		self.caption = existingImage.wrappedCaption
		self.imageUrlString = existingImage.wrappedImageUrlString
	}
	
//	MARK: - Methods
	
	func createPhoto() {
		let newPhoto = photoService.createPhoto(caption: caption)
		
		coreDataManager.save()
		fileManager.saveImage(id: newPhoto.wrappedImageUrlString, image: image)
	}
	
	func saveChanges() {
		guard let imageUrlString,
			  let savedPhoto = findExistingPhoto() else { return }
		
		savedPhoto.caption = caption
		
		coreDataManager.save()
		fileManager.saveImage(id: imageUrlString, image: image)
	}
	
	func deletePhoto() {
		guard let imageUrlString,
			  let savedPhoto = findExistingPhoto() else { return }
		
		fileManager.deleteImage(id: imageUrlString)
		coreDataManager.deletePhoto(photo: savedPhoto)
	}
	
	private func fetchPhotos() -> [Photo] {
		photoService.fetchPhotos()
	}
	
	private func findExistingPhoto() -> Photo? {
		let allPhotos = fetchPhotos()
		
		if let existingPhoto = allPhotos.first(where: { $0.imageUrlString == imageUrlString }) 
		{ return existingPhoto } else { return nil }
	}
}
