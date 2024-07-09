//
//  EditPhotoViewModel.swift
//  Seedling
//
//  Created by Laurie Cai on 7/2/24.
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
		
	}
}
