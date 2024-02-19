//
//  AddNoteView.swift
//  Seedling
//
//  Created by Laurie Cai on 2/18/24.
//

import SwiftUI

struct AddNoteView: View {
	
	@ObservedObject var viewModel: DetailViewModel
	
	@Environment(\.dismiss) var dismiss
	
	@State private var title: String = ""
	@State private var bodyText: String = ""
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Title", text: $title)
				}
				
				Section("Description") {
					TextEditor(text: $bodyText)
				}
				
				Button("Save") {
					viewModel.addNote(
						plant: viewModel.plant,
						title: title,
						body: bodyText
					)
					
					dismiss()
				}
			}
		}
    }
}


