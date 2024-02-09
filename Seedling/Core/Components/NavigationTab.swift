//
//  NavigationMenuItem.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationTab: View {
	
	let tabName: String
	
	@Binding var selectedTab: String
	
	var body: some View {
		Button {
			withAnimation(.spring()) {
				selectedTab = tabName
			}
		} label: {
			VStack(spacing: 10) {
				Rectangle()
					.fill(Color.gray)
					.frame(width: 26, height: 26)
					.cornerRadius(8)
				
				Text(tabName)
					.font(.handjet(.bold, size: 18))
					.foregroundStyle(Color.theme.textLight)
			}
			.padding()
			.background(Color.white.opacity(selectedTab == tabName ? 0.08 : 0))
			.clipShape(RoundedRectangle(cornerRadius: 8))
		}
	}
}
