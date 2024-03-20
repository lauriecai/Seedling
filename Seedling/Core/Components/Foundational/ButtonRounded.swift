//
//  ButtonRounded.swift
//  Seedling
//
//  Created by Laurie Cai on 3/20/24.
//

import SwiftUI

struct ButtonRounded: View {
	
	let text: String
	
    var body: some View {
        Text(text)
			.font(.handjet(.bold, size: 20))
			.frame(height: 65)
			.padding(.horizontal, 30)
			.foregroundStyle(Color.black)
			.background(Color.theme.backgroundAccent)
			.clipShape(
				RoundedRectangle(cornerRadius: 100)
			)
    }
}

#Preview {
	ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
		Color.theme.backgroundPrimary
			.ignoresSafeArea()
		
		HStack(spacing: 20) {
			ButtonRounded(text: "Update stage")
			ButtonCircle(icon: "icon-plus")
		}
		.padding(.horizontal, 20)
		.padding(.bottom, 20)
	}
}
