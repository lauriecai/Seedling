//
//  LabelProperty.swift
//  Seedling
//
//  Created by Laurie Cai on 5/11/24.
//

import SwiftUI

struct LabelProperty: View {
	
	let iconName: String?
	let propertyLabel: String
	let propertyValue: String
	
	init(label: String, value: String) {
		self.iconName = nil
		self.propertyLabel = label
		self.propertyValue = value
	}
	
	init(iconName: String, label: String, value: String) {
		self.iconName = iconName
		self.propertyLabel = label
		self.propertyValue = value
	}
	
    var body: some View {
		HStack(alignment: .center, spacing: 10) {
			
			if let image = iconName {
				ZStack {
					Color.theme.textGrey.opacity(0.25)
						.frame(width: 40, height: 40)
						.clipShape(RoundedRectangle(cornerRadius: 8))
					
					Image(systemName: image)
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.foregroundStyle(Color.theme.textPrimary)
				}
			}
			
			VStack(alignment: .leading, spacing: 2) {
				Text(propertyLabel)
					.font(.handjet(.bold, size: 16))
					.foregroundStyle(Color.theme.textGrey)
				Text(propertyValue)
					.font(.handjet(.medium, size: 22))
					.foregroundStyle(Color.theme.textPrimary)
			}
		}
    }
}

#Preview {
	VStack {
		LabelProperty(iconName: "photo.fill", label: "Image", value: "Ooooh, an image!")
	}
}
