//
//  FileManager.swift
//  Seedling
//
//  Created by Laurie Cai on 6/25/24.
//

import Foundation
import SwiftUI

extension FileManager {
	
	func saveImage(id: String, image: UIImage) {
		if let data = image.jpegData(compressionQuality: 0.5) {
			do {
				let url = URL.documentsDirectory.appendingPathComponent("\(id).jpeg")
				try data.write(to: url)
			} catch {
				print("Error saving image to Documents Directory: \(error.localizedDescription)")
			}
		}
	}
	
	func fetchImage(id: String) -> UIImage? {
		let url = URL.documentsDirectory.appendingPathComponent("\(id).jpeg")
		
		do {
			let data = try Data(contentsOf: url)
			return UIImage(data: data)
		} catch {
			print("Error fetching image from Documents Directory: \(error.localizedDescription)")
			return nil
		}
	}
	
	func deleteImage(id: String) {
		let url = URL.documentsDirectory.appendingPathComponent("\(id).jpeg")
		
		if fileExists(atPath: url.path()) {
			do {
				try removeItem(at: url)
			} catch {
				print("Error deleting image from Documents Directory: \(error.localizedDescription)")
			}
		}
	}
}
