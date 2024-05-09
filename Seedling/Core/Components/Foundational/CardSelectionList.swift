//
//  CardSelectionList.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct CardSelectionList<T>: View where T: Hashable & RawRepresentable & Definable, T.RawValue == String {
	
	let items: [T]

	let selectedPillLabel: String
	@Binding var selectedItem: T
	@Binding var selectedItemIndex: Int
	
    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 10) {
				ForEach(Array(items.enumerated()), id: \.1) { index, item in
					CardSelectable(
						title: item.rawValue,
						description: item.definition,
						isSelected: index == selectedItemIndex,
						selectedPillLabel: selectedPillLabel
					)
					.onTapGesture {
						selectedItem = item
						selectedItemIndex = index
						print("Card tapped!")
					}
				}
			}
		}
    }
}

#Preview {
	CardSelectionList(
		items: PlantStage.allCases,
		selectedPillLabel: "Selected",
		selectedItem: .constant(.seedling),
		selectedItemIndex: .constant(2)
	)
}
