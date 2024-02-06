//
//  NavigationMenuItem.swift
//  Seedling
//
//  Created by Laurie Cai on 2/5/24.
//

import SwiftUI

struct NavigationMenuItem: View {
	
	let name: String
	
	var body: some View {
		VStack {
			Rectangle()
				.fill(Color.gray)
				.frame(width: 26, height: 26)
				.cornerRadius(8)
			
			Text(name)
				.font(.handjet(.bold, size: 16))
				.foregroundStyle(Color.theme.textLight)
		}
	}
}

#Preview {
    NavigationMenuItem(name: "Add Plant")
}
