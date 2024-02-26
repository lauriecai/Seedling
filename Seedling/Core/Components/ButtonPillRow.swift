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
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(rowLabel)
				.font(.handjet(.bold, size: 24))
			
			ScrollView(.horizontal) {
				HStack {
					ForEach(items, id: \.self) { item in
						ButtonPill(pillText: item)
					}
				}
			}
		}
    }
}

#Preview {
	ButtonPillRow(rowLabel: "Stage", items: ["Seed", "Seedling", "Bulb", "Transplant", "Seed", "Seedling", "Bulb", "Transplant"])
}
