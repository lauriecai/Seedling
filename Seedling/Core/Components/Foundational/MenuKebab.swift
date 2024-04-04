//
//  MenuKebab.swift
//  Seedling
//
//  Created by Laurie Cai on 4/4/24.
//

import SwiftUI

struct MenuKebab: View {
    var body: some View {
		Image(systemName: "ellipsis")
			.font(.handjet(.bold, size: 20))
			.foregroundStyle(Color.theme.textSecondary)
			.rotationEffect(.degrees(-90))
			.padding(.leading, 20)
			.frame(maxHeight: .infinity)
    }
}

#Preview {
    MenuKebab()
}
