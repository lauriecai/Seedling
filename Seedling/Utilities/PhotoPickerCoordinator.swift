//
//  PhotoPickerCoordinator.swift
//  Seedling
//
//  Created by Laurie Cai on 5/9/24.
//

import Foundation
import SwiftUI

class PhotoPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	@Binding var image: UIImage?
	@Binding var isShown: Bool
	
	init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
		_image = image
		_isShown = isShown
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			image = uiImage
			isShown = false
		}
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		isShown = false
	}
}
