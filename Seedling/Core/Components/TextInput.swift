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
		VStack(alignment: .leading, spacing: 8) {
			Text(inputHeader)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
			
			ZStack(alignment: .leading) {
				TextField("", text: $name, prompt: Text(inputPlaceholder).foregroundStyle(Color.theme.textSecondary)
				)
				.font(.handjet(.bold, size: 22))
				.padding(.horizontal)
				.padding(.vertical, 10)
				.foregroundStyle(Color.theme.textPrimary)
				.background(Color.theme.backgroundAccent)
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.autocorrectionDisabled()
				.textInputAutocapitalization(.never)
			}
		}
	}
}

#Preview {
	textInput(inputHeader: "Name", inputPlaceholder: "e.g. Tomato", name: .constant(""))
}
