//
//  TextInput.swift
//  Seedling
//
//  Created by Laurie Cai on 2/26/24.
//

import SwiftUI

struct TextInput: View {
	
	let inputHeader: String
	let headerDescription: String?
	
	let inputPlaceholder: String
	
	@Binding var text: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			HStack {
				Text(inputHeader)
					.font(.handjet(.bold, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
				
				if let description = headerDescription {
					Text("(\(description))")
						.font(.handjet(.regular, size: 18))
						.foregroundStyle(Color.theme.textSecondary)
				}
			}
			
			TextField("", text: $text, prompt: Text(inputPlaceholder).foregroundStyle(Color.theme.textSecondary))
					.font(.handjet(.medium, size: 20))
					.padding(.horizontal)
					.padding(.vertical, 10)
					.foregroundStyle(Color.theme.textPrimary)
					.background(Color.theme.backgroundAccent)
					.clipShape(RoundedRectangle(cornerRadius: 8))
					.autocorrectionDisabled()
		}
	}
}

#Preview {
	ZStack {
		Color.theme.backgroundPrimary
			.ignoresSafeArea()
		
		TextInput(inputHeader: "Variety", headerDescription: "Optional", inputPlaceholder: "e.g. Beefsteak, Roma", text: .constant(""))
	}
}
