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
			NavigationTab(tabLabel: "Garden", tabIconName: "icon-garden")
			Spacer()
			NavigationTab(tabLabel: "Journal", tabIconName: "icon-journal")
			Spacer()
			NavigationTab(tabLabel: "Tasks", tabIconName: "icon-tasks")
		}
		.padding(.horizontal, 40)
		.background(Color.theme.backgroundDark)
    }
}

#Preview {
	NavigationBar()
}
