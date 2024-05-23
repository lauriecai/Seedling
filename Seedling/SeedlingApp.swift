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
	
	@State private var showLaunchView: Bool = true
	
	init() {
		UINavigationBar.appearance().titleTextAttributes = [
			.foregroundColor: UIColor(Color.theme.textPrimary),
			.font: UIFont(name: "Handjet-Bold", size: 24)!
		]
	}
	
    var body: some Scene {
		WindowGroup {
			NavigationStack {
				ContentView()
			}
			.environmentObject(viewModel)
		}
    }
}

struct ContentView: View {
	
	@State private var selectedItem: Int = 0
	
	var body: some View {
		ZStack(alignment: .bottom) {
			TabView(selection: $selectedItem) {
				HomeView()
					.tag(0)
				
				TasksView()
					.tag(1)
			}
			
			NavigationBar(selectedIndex: $selectedItem)
		}
	}
}
