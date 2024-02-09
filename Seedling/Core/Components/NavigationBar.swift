//
//  NavigationMenu.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationBar: View {
	
	@Binding var selectedTab: String
	
    var body: some View {
		HStack {
			Spacer()
			NavigationTab(tabName: "Garden", selectedTab: $selectedTab)
			Spacer()
			NavigationTab(tabName: "Add Plant", selectedTab: $selectedTab)
			Spacer()
		}
		.padding(.vertical, 10)
		.background(Color.theme.backgroundDark)
    }
}
