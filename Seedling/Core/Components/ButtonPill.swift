//
//  ButtonPill.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct ButtonPill: View {
	
	let pillText: String
	let isSelected: Bool
	
    var body: some View {
			Text(pillText)
				.font(.handjet(.bold, size: 22))
				.foregroundStyle(isSelected ? Color.theme.textPrimary : Color.theme.textPrimary.opacity(0.4))
				.padding(.vertical, 10)
				.padding(.horizontal, 18)
				.background(isSelected ? Color.theme.accentLightGreen : Color.theme.backgroundAccent)
				.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
	ButtonPill(pillText: "Seed", isSelected: false)
}
