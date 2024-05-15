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
	
	let accentTheme: Bool
	
    var body: some View {
			Text(pillText)
				.font(.handjet(.bold, size: 22))
				.foregroundStyle(isSelected ? Color.theme.textPrimary : accentTheme ? Color.theme.textSecondary : Color.theme.textGrey)
				.padding(.vertical, 10)
				.padding(.horizontal, 18)
				.background(isSelected ? Color.theme.accentLightGreen : accentTheme ? Color.theme.backgroundAccent.opacity(0.8) : Color.theme.backgroundGrey)
				.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	ButtonPill(pillText: "Seed", isSelected: false, accentTheme: true)
}
