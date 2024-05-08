//
//  TextPill.swift
//  Seedling
//
//  Created by Laurie Cai on 5/1/24.
//

import SwiftUI

struct TextPill: View {
	
	let label: String
	let backgroundColor: Color
	
    var body: some View {
		Text(label)
			.font(.handjet(.bold, size: 18))
			.foregroundStyle(Color.theme.textPrimary)
			.padding(5)
			.padding(.horizontal, 3)
			.background(backgroundColor)
			.clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
	TextPill(label: "New Stage", backgroundColor: Color.theme.accentYellow)
}
