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
	
	@FocusState private var inputFocused: Bool
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(inputHeader)
				.font(.handjet(.bold, size: 20))
				.foregroundStyle(Color.theme.textPrimary)
			
			ZStack {
				TextEditor(text: $text)
					.font(.handjet(.medium, size: 22))
					.scrollContentBackground(.hidden)
					.padding(.horizontal, 12)
					.padding(.vertical, 6)
					.background(Color.theme.backgroundAccent)
					.foregroundStyle(Color.theme.textPrimary)
					.frame(height: 200)
					.clipShape(RoundedRectangle(cornerRadius: 8))
					.focused($inputFocused)
				
				if text.isEmpty {
					Text(inputPlaceholder)
						.font(.handjet(.medium, size: 22))
						.foregroundStyle(Color.theme.textSecondary)
						.frame(maxWidth: .infinity, maxHeight: 200, alignment: .topLeading)
						.padding(.horizontal)
						.padding(.vertical, 14)
						.onTapGesture {
							inputFocused.toggle()
						}
				}
			}
		}
	}
}

#Preview {
	TextEditorInput(inputHeader: "How's your plant doing?", inputPlaceholder: "Start writing...", text: .constant(""))
}
