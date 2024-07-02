//
//  Photo+Extension.swift
//  Seedling
//
//  Created by Laurie Cai on 6/27/24.
//

import Foundation
import SwiftUI

extension Photo {
	
	var wrappedCaption: String {
		caption ?? ""
	}
	
	var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
	
	var wrappedImageUrlString: String {
		imageUrlString ?? ""
	}
	
	var uiImage: UIImage {
		if !wrappedImageUrlString.isEmpty,
		   let image = FileManager().fetchImage(id: wrappedImageUrlString) {
			return image
		} else {
			return UIImage(systemName: "photo")! // need placeholder
		}
	}
}
