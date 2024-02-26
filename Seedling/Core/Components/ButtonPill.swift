//
//  ButtonPill.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct ButtonPill: View {
	
	let pillText: String
	
    var body: some View {
			Text(pillText)
				.font(.handjet(.bold, size: 24))
				.padding()
				.padding(.horizontal, 8)
				.background(Color.theme.backgroundAccent)
				.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ButtonPill(pillText: "Seed")
}
