//
//  NavigationBar.swift
//  Seedling
//
//  Created by Laurie Cai on 3/5/24.
//

import SwiftUI

struct NavigationBar: View {
	
	@Binding var selectedIndex: Int
	
    var body: some View {
		HStack(spacing: 140) {
			ForEach(NavigationItems.allCases, id: \.self) { item in
				Button {
					selectedIndex = item.rawValue
					UIImpactFeedbackGenerator(style: .light).impactOccurred()
				} label: {
					NavigationTab(tabLabel: item.label, tabIconName: item.iconName, isSelected: selectedIndex == item.rawValue)
				}
			}
		}
		.frame(maxWidth: .infinity)
		.background(Color.theme.backgroundDark)
    }
}

#Preview {
	NavigationBar(selectedIndex: .constant(1))
}

enum NavigationItems: Int, CaseIterable {
	case garden = 0
	case tasks = 1
	
	var label: String {
		switch self {
		case .garden: 
			return "Garden"
		case .tasks: 
			return "Tasks"
		}
	}
	
	var iconName: String {
		switch self {
		case .garden:
			return "icon-garden"
		case .tasks:
			return "icon-tasks"
		}
	}
}
