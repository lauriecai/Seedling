//
//  EditPhotoMode.swift
//  Seedling
//
//  Created by Laurie Cai on 7/9/24.
//

import Foundation
import SwiftUI

enum EditPhotoMode: Identifiable, View {
	case create(UIImage)
	case edit(Photo)
	
	var id: String {
		switch self {
		case .create: return "create"
		case .edit: return "edit"
		}
	}
	
	var body: some View {
		switch self {
		case .create(let selectedImage):
			EditPhotoView(viewModel: EditPhotoViewModel(newImage: selectedImage))
		case .edit(let savedPhoto):
			EditPhotoView(viewModel: EditPhotoViewModel(existingPhoto: savedPhoto))
		}
	}
}
