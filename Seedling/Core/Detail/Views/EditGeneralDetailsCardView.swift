//
//  EditGeneralCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 5/15/24.
//

import SwiftUI

struct EditGeneralDetailsCardView: View {
	
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView {
				VStack(alignment: .leading, spacing: 15) {
					header
					
					VStack(alignment: .leading, spacing: 2) {
						Text("Name")
							.font(.handjet(.bold, size: 16))
							.foregroundStyle(Color.theme.textGrey)
						
						Text("Eggplant")
							.font(.handjet(.medium, size: 22))
							.foregroundStyle(Color.theme.textPrimary)
					}
					
					VStack(alignment: .leading, spacing: 2) {
						Text("Variety")
							.font(.handjet(.bold, size: 16))
							.foregroundStyle(Color.theme.textGrey)
						
						Text("Ichiban")
							.font(.handjet(.medium, size: 22))
							.foregroundStyle(Color.theme.textPrimary)
					}
					
					Text("Type")
						.font(.handjet(.bold, size: 16))
						.foregroundStyle(Color.theme.textGrey)
					
					Text("Stage")
						.font(.handjet(.bold, size: 16))
						.foregroundStyle(Color.theme.textGrey)
				}
				.padding()
			}
		}
		.navigationTitle("Edit General")
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { cancelButton }
			ToolbarItem(placement: .topBarTrailing) { saveChangesButton }
		}
    }
}

#Preview {
	EditGeneralDetailsCardView()
}

extension EditGeneralDetailsCardView {
	
	private var header: some View {
		HStack {
			Text("General")
				.font(.handjet(.extraBold, size: 24))
				.foregroundStyle(Color.theme.textPrimary)
			Spacer()
		}
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			dismiss()
		}
	}
	
	private var cancelButton: some View {
		Button("Cancel") {
			dismiss()
		}
		.font(.handjet(.medium, size: 20))
		.foregroundStyle(Color.theme.textSecondary)
	}
}
