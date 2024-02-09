//
//  NavigationMenu.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationBar: View {
	
	@State private var currentTab = "Garden"
	
    var body: some View {
		ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
			TabView(selection: $currentTab) {
				Text("Garden")
					.tag("Garden")
				
				Text("Add Plant")
					.tag("Add Plant")
			}
			
			HStack {
				Spacer()
				NavigationTab(tabName: "Garden", selectedTab: $currentTab)
				Spacer()
				NavigationTab(tabName: "Add Plant", selectedTab: $currentTab)
				Spacer()
			}
			.padding(.vertical, 10)
			.background(Color.theme.backgroundDark)
		}
		.ignoresSafeArea()
    }
}

#Preview {
    NavigationBar()
}
