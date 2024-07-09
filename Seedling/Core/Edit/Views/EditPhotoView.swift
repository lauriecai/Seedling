//
//  EditPhotoView.swift
//  Seedling
//
//  Created by Laurie Cai on 7/2/24.
//

import PhotosUI
import SwiftUI

struct EditPhotoView: View {
	
	@ObservedObject var viewModel: EditPhotoViewModel
	@ObservedObject var imagePickerService: ImagePickerService
	
	@Environment(\.dismiss) var dismiss
	
	let coreDataManager = CoreDataManager.shared
	let fileManager = FileManager()
	
    var body: some View {
		NavigationStack {
			VStack {
				Image(uiImage: viewModel.image)
					.resizable()
					.scaledToFit()
				
				TextField("Description", text: $viewModel.caption)
				
				HStack {
					if viewModel.editingExistingImage {
						PhotosPicker("Edit Image",
							selection: $imagePickerService.selectedPhotosPickerItem,
							matching: .images,
							photoLibrary: .shared())
					}
					
					Button {
						if viewModel.editingExistingImage {
							viewModel.saveChanges()
						} else {
							viewModel.createPhoto()
						}
						dismiss()
					} label: {
						Text("Save")
					}
				}
				
				Spacer()
			}
			.navigationTitle(viewModel.editingExistingImage ? "Edit Photo" : "New Photo")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button("Cancel") { dismiss() }
				}
				
				if viewModel.editingExistingImage {
					ToolbarItem(placement: .topBarTrailing) {
						Button {
							viewModel.deletePhoto()
							dismiss()
						} label: {
							Image(systemName: "trash")
						}
					}
				}
			}
			.onChange(of: imagePickerService.selectedImage) { _, newImage in
				if let newImage { viewModel.image = newImage }
			}
		}
    }
}

#Preview {
	EditPhotoView(viewModel: EditPhotoViewModel(newImage: UIImage(systemName: "photo")!), imagePickerService: ImagePickerService())
}
