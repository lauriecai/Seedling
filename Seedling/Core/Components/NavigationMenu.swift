//
//  NavigationMenu.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationMenu: View {
    var body: some View {
		HStack {
			NavigationMenuItem(name: "Garden")
			Spacer()
			NavigationMenuItem(name: "Add Plant")
			Spacer()
			NavigationMenuItem(name: "To-do List")
		}
		.padding()
		.padding(.horizontal, 30)
		.padding(.bottom, 5)
		.background(Color.theme.backgroundDark)
		.frame(maxHeight: .infinity, alignment: .bottom)
		.ignoresSafeArea()
    }
}

#Preview {
    NavigationMenu()
}
