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
	
//	@Binding var selectedTab: String
	
	var body: some View {
		Button {
//			withAnimation(.spring()) {
//				selectedTab = tabName
//			}
			print("\(tabLabel) tapped")
		} label: {
			VStack(spacing: 2) {
				Image(tabIconName)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.foregroundStyle(isSelected ? Color.theme.accentGreen : Color.theme.)
					.frame(width: 28, height: 28)
				
				Text(tabLabel)
					.font(.handjet(.medium, size: 16))
					.foregroundStyle(Color.theme.textLight)
			}
			.padding(.top, 10)
		}
	}
}

#Preview(traits: .sizeThatFitsLayout) {
	NavigationTab(tabLabel: "Tasks", tabIconName: "icon-tasks", isSelected: true)
		.background(Color.theme.backgroundDark)
}
