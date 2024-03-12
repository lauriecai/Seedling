//
//  Dropdown.swift
//  Seedling
//
//  Created by Laurie Cai on 3/12/24.
//

import SwiftUI

struct Dropdown: View {
	
	let pickerHeader: String
	let items: [String]
	
	@State private var selectedIndex: Int = 0
	
    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(pickerHeader)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
			
//			Picker("Plant", selection: $selectedItem) {
//				ForEach(items.indices, id: \.self) { index in
//					Text(items[index])
//						.font(.handjet(.medium, size: 22))
//						.foregroundStyle(Color.theme.textPrimary)
//				}
//			}
//			.background(Color.theme.backgroundAccent)
//			.pickerStyle(.menu)
			
			Menu {
				ForEach(items.indices, id: \.self) { index in
					Button {
						selectedIndex = index
					} label: {
						Text(items[index])
					}
				}
			} label: {
				HStack {
					Text(items[selectedIndex])
						.font(.handjet(.medium, size: 22))
						.foregroundStyle(Color.theme.textPrimary)
					
					Spacer()
					
					Image(systemName: "chevron.up.chevron.down")
						.foregroundStyle(Color.theme.textSecondary)
				}
				.padding()
				.background(Color.theme.backgroundAccent)
				.frame(maxWidth: .infinity, alignment: .leading)
				.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	ZStack {
		Color.theme.backgroundPrimary
			.ignoresSafeArea()
		
		Dropdown(pickerHeader: "Fruits", items: ["apple", "banana", "cherry", "orange", "strawberry", "watermelon"])
	}
}
