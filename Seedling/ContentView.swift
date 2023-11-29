//
//  ContentView.swift
//  Seedling
//
//  Created by Laurie Cai on 11/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
				.font(.custom("Handjet-Bold", size: 24))
			Text("Hello, world 2!")
				.font(.handjet(.bold, size: 24))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
