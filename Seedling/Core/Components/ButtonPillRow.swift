//
//  ButtonPillRow.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct ButtonPillRow: View {
	
	let rowLabel: String
	let items: [String]
	
	@State private var selectedIndex: Int = 0
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(rowLabel)
				.font(.handjet(.bold, size: 22))
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(0..<items.count, id: \.self) { i in
						ButtonPill(pillText: items[i], isSelected: i == selectedIndex)
							.onTapGesture {
								selectedIndex = i
							}
					}
				}
			}
		}
		.foregroundStyle(Color.theme.textPrimary)
    }
}

#Preview {
	ButtonPillRow(rowLabel: "Stage", items: ["Seed", "Seedling", "Bulb", "Transplant"])
}
