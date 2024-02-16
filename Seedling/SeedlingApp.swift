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
			NavigationStack {
				ZStack {
					HomeView()
				}
			}
			.environmentObject(viewModel)
		}
    }
}
