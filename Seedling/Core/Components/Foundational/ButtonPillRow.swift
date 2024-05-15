//
//  ButtonPillRow.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct ButtonPillRow<T>: View where T: Hashable & RawRepresentable, T.RawValue == String {
	
	let rowLabel: String?
	let items: [T]
	
	let accentTheme: Bool
	
	@Binding var selectedItem: T
	@Binding var selectedIndex: Int
	
    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			if let label = rowLabel {
				Text(label)
					.font(.handjet(.bold, size: 20))
			}
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(Array(items.enumerated()), id: \.1) { index, item in
						ButtonPill(pillText: item.rawValue, isSelected: index == selectedIndex, accentTheme: accentTheme)
							.onTapGesture {
								selectedIndex = index
								selectedItem = item
							}
					}
				}
			}
		}
		.foregroundStyle(Color.theme.textPrimary)
    }
}

#Preview {
	ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, accentTheme: true, selectedItem: .constant(.seed), selectedIndex: .constant(0))
}
