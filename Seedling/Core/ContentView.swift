//
//  ContentView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/9/24.
//

import SwiftUI

struct ContentView: View {
	
	
	@State var currentTab = "Garden"
	
    var body: some View {
		ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
			TabView(selection: $currentTab) {
				HomeView()
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
    ContentView()
}
