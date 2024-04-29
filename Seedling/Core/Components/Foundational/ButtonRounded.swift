//
//  ButtonRounded.swift
//  Seedling
//
//  Created by Laurie Cai on 3/20/24.
//

import SwiftUI

struct ButtonRounded: View {
	
	let iconName: String?
	let text: String
	
	init(text: String) {
		self.text = text
		self.iconName = nil
	}
	
	init(iconName: String, text: String) {
		self.iconName = iconName
		self.text = text
	}
	
    var body: some View {
		HStack(spacing: 12) {
			if let iconName = iconName {
				Image(systemName: iconName)
					.bold()
			}
			
			Text(text)
				.font(.handjet(.bold, size: 20))
				.frame(height: 55)
		}
		.padding(.horizontal, 20)
		.foregroundStyle(Color.black)
		.background(Color.theme.accentLightGreen)
		.clipShape(
			RoundedRectangle(cornerRadius: 100)
		)
		.shadow(color: .black.opacity(0.10), radius: 5, x: 0, y: 5)
    }
}

#Preview {
	ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
		Color.theme.backgroundPrimary
			.ignoresSafeArea()
		
		VStack(alignment: .trailing, spacing: 20) {
			VStack(alignment: .trailing, spacing: 12) {
				ButtonRounded(iconName: "pencil", text: "Add Note")
				ButtonRounded(iconName: "photo.fill", text: "Add Photo")
				ButtonRounded(iconName: "sparkles", text: "Update Stage")
			}
			
			ButtonCircle(icon: "icon-plus")
		}
		.padding(.horizontal, 20)
		.padding(.bottom, 20)
	}
}
