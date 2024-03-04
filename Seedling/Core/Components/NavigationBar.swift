//
//  NavigationMenu.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationBar: View {
	
    var body: some View {
		HStack {
			NavigationTab(tabLabel: "Garden", tabIconName: "icon-garden", isSelected: true)
			Spacer()
			NavigationTab(tabLabel: "Journal", tabIconName: "icon-journal", isSelected: false)
			Spacer()
			NavigationTab(tabLabel: "Tasks", tabIconName: "icon-tasks", isSelected: false)
		}
		.padding(.horizontal, 40)
		.background(Color.theme.backgroundDark)
    }
}

#Preview {
	NavigationBar()
}
