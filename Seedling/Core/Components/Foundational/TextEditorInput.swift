//
//  TextEditorInput.swift
//  Seedling
//
//  Created by Laurie Cai on 2/28/24.
//

import SwiftUI

struct TextEditorInput: View {
	
	let inputHeader: String?
	let inputPlaceholder: String
	
	let accentTheme: Bool
	
	@Binding var text: String
	
	@FocusState private var inputFocused: Bool
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			if let header = inputHeader {
				Text(header)
					.font(.handjet(.bold, size: 20))
					.foregroundStyle(Color.theme.textPrimary)
			}
			
			ZStack {
				TextEditor(text: $text)
					.font(.handjet(.medium, size: 20))
					.scrollContentBackground(.hidden)
					.padding(.horizontal, 12)
					.padding(.top, 6)
					.padding(.bottom, 12)
					.background(accentTheme ? Color.theme.backgroundAccent : Color.theme.backgroundGrey)
					.foregroundStyle(Color.theme.textPrimary)
					.frame(height: 200)
					.clipShape(RoundedRectangle(cornerRadius: 8))
					.focused($inputFocused)
				
				if text.isEmpty {
					Text(inputPlaceholder)
						.font(.handjet(.medium, size: 20))
						.foregroundStyle(accentTheme ? Color.theme.textSecondary : Color.theme.textGrey)
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
	TextEditorInput(inputHeader: "How's your plant doing?", inputPlaceholder: "Start writing...", accentTheme: true, text: .constant(""))
}
