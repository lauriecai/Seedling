//
//  ImagePickerService.swift
//  Seedling
//
//  Created by Laurie Cai on 6/25/24.
//

import CoreData
import PhotosUI
import SwiftUI

// MARK: Description
// Takes a selected image and converts it into a usable image

@MainActor
class ImagePickerService: ObservableObject {
	
	@Published var selectedPhotosPickerItem: PhotosPickerItem? {
		didSet {
			Task { try await convertPhotosPickerItem(from: selectedPhotosPickerItem) }
		}
	}
	
	@Published var selectedImage: UIImage?
	
	let coreDataManager = CoreDataManager.shared
	
//	MARK: - Methods
	
	func convertPhotosPickerItem(from photosPickerItem: PhotosPickerItem?) async throws {
		do {
			guard let data = try await photosPickerItem?.loadTransferable(type: Data.self),
				  let convertedImage = UIImage(data: data) else { return }
			
			selectedImage = convertedImage
		} catch {
			print("Error converting selected image: \(error.localizedDescription)")
		}
	}
}
