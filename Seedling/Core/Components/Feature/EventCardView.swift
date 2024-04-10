//
//  EventCardView.swift
//  Seedling
//
//  Created by Laurie Cai on 3/15/24.
//

import SwiftUI

struct EventCardView: View {

	let event: Event
	
	@Binding var showActionSheet: Bool
	@Binding var showActionsForEvent: Event?
	
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			eventTitle
			
			HStack {
				timestamp
				Spacer()
				eventActions
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color.theme.backgroundAccent)
		.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension EventCardView {
	
	private var eventTitle: some View {
		Text(event.wrappedTitle)
			.font(.handjet(.bold, size: 20))
			.foregroundStyle(Color.theme.textPrimary)
	}
	
	private var timestamp: some View {
		HStack {
			Text(event.wrappedTimestamp.asDateAndTime())
				.font(.handjet(.regular, size: 18))
				.foregroundStyle(Color.theme.textSecondary)
			
			Spacer()
		}
	}
	
	private var eventActions: some View {
		Button {
			showActionSheet = true
			showActionsForEvent = event
		} label: {
			MenuKebab()
				.padding(.top, 10)
				.frame(maxHeight: .infinity, alignment: .top)
				.opacity(0.7)
		}
	}
}
