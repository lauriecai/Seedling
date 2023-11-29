//
//  HomeView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			VStack(alignment: .leading, spacing: 15) {
				weatherRow
				dateHeader
				
			}
			.padding(.horizontal)
		}
    }
}

#Preview {
    HomeView()
}

extension HomeView {
	
	private var dateHeader: some View {
		Text("Wednesday, November 15")
			.font(.handjet(.extraBold, size: 32))
	}
	
	private var weatherRow: some View {
		HStack(spacing: 10) {
			weatherCard
			weatherCard
			weatherCard
			weatherCard
			weatherCard
		}
		.frame(maxWidth: .infinity)
	}
	
	private var weatherCard: some View {
		VStack(spacing: 5) {
			Text("Fri")
				.font(.handjet(.regular, size: 18))
			
			Rectangle()
				.fill(Color.yellow)
				.frame(width: 40, height: 30)
			
			HStack {
				Text("77")
					.font(.handjet(.bold, size: 18))
				Text("56")
					.font(.handjet(.regular, size: 18))
			}
		}
		.padding(.vertical, 5)
		.padding(.horizontal, 10)
		.background(Color.white)
		.cornerRadius(8)
	}
}
