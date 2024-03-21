//
//  ButtonPillRow.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct ButtonPillRow<T>: View where T: Hashable & RawRepresentable, T.RawValue == String {
	
	let rowLabel: String
	let items: [T]
	
//	@State private var selectedIndex: Int = 0
	
	@Binding var selectedItem: T
	@Binding var selectedIndex: Int
	
    var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(rowLabel)
				.font(.handjet(.bold, size: 20))
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(0..<items.count, id: \.self) { i in
						ButtonPill(pillText: items[i].rawValue, isSelected: i == selectedIndex)
							.onTapGesture {
								selectedIndex = i
								selectedItem = items[i]
							}
					}
				}
			}
		}
		.foregroundStyle(Color.theme.textPrimary)
    }
}

#Preview {
	ButtonPillRow(rowLabel: "Stage", items: PlantStage.allCases, selectedItem: .constant(.seed), selectedIndex: .constant(0))
}
