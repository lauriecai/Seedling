//
//  TextInput.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct textInput: View {
	let inputHeader: String
	let inputPlaceholder: String
	@Binding var name: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(inputHeader)
				.font(.handjet(.bold, size: 24))
			
			ZStack(alignment: .leading) {
				TextField("", text: $name, prompt: Text(inputPlaceholder).foregroundStyle(Color.theme.textPrimary.opacity(0.4))
				)
				.padding()
				.background(Color.theme.backgroundAccent)
				.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
		.font(.handjet(.bold, size: 24))
	}
}

#Preview {
	textInput(inputHeader: "Name", inputPlaceholder: "e.g. Tomato", name: .constant(""))
}
