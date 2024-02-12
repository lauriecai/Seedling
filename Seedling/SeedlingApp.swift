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
	
    var body: some Scene {
		WindowGroup {
			ZStack {
				HomeView()
					.environmentObject(viewModel)
				
				ZStack {
					if showLaunchView {
						LaunchView(showLaunchView: $showLaunchView)
							.transition(.move(edge: .leading))
					}
				}
				.zIndex(2.0)
			}
		}
    }
}
