//
//  NoteView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/14/24.
//

import SwiftUI

struct NoteView: View {
	
//	let plant: Plant
	
    var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("February 14, 2023: 3:05pm")
				.font(.handjet(.regular, size: 16))
				.foregroundStyle(Color.theme.textPrimary.opacity(0.50))
			
			Text("They've finally sprouted!")
				.font(.handjet(.bold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
			
			Text("I didn't think they were going to survive. What a pleasant surprise. Maybe I should stick them outside for a few hours everyday to get the stems to thicken up a bit. Hope no pests get to them.")
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textPrimary)
		}
		.padding()
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NoteView()
}
