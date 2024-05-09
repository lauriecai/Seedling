//
//  PhotoPicker.swift
//  Seedling
//
//  Created by Laurie Cai on 5/9/24.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
	
	typealias UIViewControllerType = UIImagePickerController
	typealias Coordinator = PhotoPickerCoordinator
	
	@Binding var image: UIImage?
	@Binding var isShown: Bool
	
	var sourceType: UIImagePickerController.SourceType = .camera
	
	func makeCoordinator() -> PhotoPicker.Coordinator {
		PhotoPickerCoordinator(image: $image, isShown: $isShown)
	}
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.sourceType = sourceType
		picker.delegate = context.coordinator
		
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {}
	
}
