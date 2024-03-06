//
//  Tag.swift
//  Seedling
//
//  Created by Laurie Cai on 3/6/24.
//

import SwiftUI

struct Tag: View {
	
	let text: String
	
    var body: some View {
        Text(text)
			.font(.handjet(.bold, size: 18))
			.foregroundStyle(Color.theme.textPrimary)
			.padding(.horizontal, 8)
			.padding(.vertical, 5)
			.background(Color.theme.backgroundAccent)
			.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    Tag(text: "Eggplant: Shikou")
}
