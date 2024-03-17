//
//  NavigationMenuItem.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationTab: View {
	
	let tabLabel: String
	let tabIconName: String
	let isSelected: Bool
	
	var body: some View {
		VStack(spacing: 2) {
			Image(tabIconName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.colorMultiply(isSelected ? Color.theme.accentLightGreen : Color.theme.textLight)
				.frame(width: 28, height: 28)
			
			Text(tabLabel)
				.font(.handjet(.medium, size: 16))
				.foregroundStyle(isSelected ? Color.theme.accentLightGreen : Color.theme.textLight)
		}
		.padding(.top, 10)
	}
}

#Preview(traits: .sizeThatFitsLayout) {
	NavigationTab(tabLabel: "Tasks", tabIconName: "icon-tasks", isSelected: true)
		.background(Color.theme.backgroundDark)
}
