//
//  DetailView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/11/24.
//

import SwiftUI

struct DetailView: View {
	
    var body: some View {
		ScrollView {
			ForEach(0..<20, id: \.self) { _ in
				NoteView()
			}
		}
    }
}

#Preview {
    DetailView()
}
