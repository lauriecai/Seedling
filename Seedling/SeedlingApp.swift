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
	
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environmentObject(viewModel)
        }
    }
}
