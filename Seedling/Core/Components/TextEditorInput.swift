//
//  TextEditorInput.swift
//  Seedling
//
//  Created by Laurie Cai on 2/28/24.
//

import SwiftUI

struct TextEditorInput: View {
	
	let inputHeader: String
	let inputPlaceholder: String
	
	@Binding var text: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(inputHeader)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
			
			ZStack {
				TextEditor(text: $text)
					.font(.handjet(.medium, size: 22))
					.scrollContentBackground(.hidden)
					.padding(12)
					.background(Color.theme.backgroundAccent)
					.foregroundStyle(Color.theme.textPrimary)
					.frame(height: 250)
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
	}
}

#Preview {
	TextEditorInput(inputHeader: "How's your plant doing?", inputPlaceholder: "Start writing...", text: .constant(""))
}
