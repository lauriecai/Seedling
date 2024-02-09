//
//  SeedlingApp.swift
//  Seedling
//
//  Created by Laurie Cai on 11/27/23.
//

import SwiftUI

@main
struct SeedlingApp: App {
	
	@StateObject private var viewModel = HomeViewModel()
	@State var currentTab = "Garden"
	
    var body: some Scene {
		WindowGroup {
			ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
				TabView(selection: $currentTab) {
					HomeView()
						.tag("Garden")
					
					Text("Add Plant") // add plant view goes here
						.tag("Add Plant")
				}
				.environmentObject(viewModel)
				
				NavigationBar(selectedTab: $currentTab)
			}
			.ignoresSafeArea()
		}
    }
}
