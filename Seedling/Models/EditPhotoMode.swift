//
//  EditPhotoMode.swift
//  Seedling
//
//  Created by Laurie Cai on 7/9/24.
//

import Foundation
import SwiftUI

enum EditPhotoMode: Identifiable, View {
	case create(Plant, UIImage)
	case edit(Plant, Photo)
	
	var id: String {
		switch self {
		case .create: return "create"
		case .edit: return "edit"
		}
	}
	
	var body: some View {
		switch self {
		case .create(let plant, let selectedImage):
			NavigationView {
				EditPhotoView(viewModel: EditPhotoViewModel(plant: plant, newImage: selectedImage))
			}
		case .edit(let plant, let savedPhoto):
			NavigationView {
				EditPhotoView(viewModel: EditPhotoViewModel(plant: plant, existingPhoto: savedPhoto))
			}
		}
	}
}
