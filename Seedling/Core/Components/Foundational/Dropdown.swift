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
	
	@Binding var selectedIndex: Int
	
    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(pickerHeader)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
			
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
						.font(.handjet(.medium, size: 20))
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
