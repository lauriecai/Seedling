//
//  EditPhotoView.swift
//  Seedling
//
//  Created by Laurie Cai on 7/2/24.
//

import PhotosUI
import SwiftUI

struct EditPhotoView: View {
	
	@ObservedObject var viewModel: EditPhotoViewModel
	
	@EnvironmentObject var imagePickerService: ImagePickerService
	
	@Environment(\.dismiss) var dismiss
	
	@FocusState private var keyboardFocused: Bool
	
	let coreDataManager = CoreDataManager.shared
	let fileManager = FileManager()
	
    var body: some View {
		ZStack {
			Color.theme.backgroundPrimary
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				VStack(spacing: 15) {
					Image(uiImage: viewModel.image)
						.resizable()
						.scaledToFit()
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.frame(maxHeight: 300)
					
					noteBodyInput
						.focused($keyboardFocused)
						.onAppear { keyboardFocused.toggle() }
					
					Spacer()
				}
				.padding(.horizontal)
			}
		}
		.onAppear {
			FirebaseEventManager.shared.logEvent(name: "EditPhotoView_appeared")
		}
		.navigationTitle(viewModel.editingExistingImage ? "Edit Caption" : "New Photo")
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) { cancelButton }
			ToolbarItem(placement: .topBarTrailing) {
				if viewModel.editingExistingImage {
					saveChangesButton
				} else {
					addPhotoButton
				}
			}
		}
		.keyboardType(.default)
		.onChange(of: imagePickerService.selectedImage) { _, newImage in
			if let newImage { viewModel.image = newImage }
		}
		.onChange(of: viewModel.caption) { viewModel.captionEdited = true }
    }
}

extension EditPhotoView {
	
	private var noteBodyInput: some View {
		TextEditorInput(inputHeader: "Description", headerDescription: "Optional", inputPlaceholder: "Start writing...", accentTheme: true, text: $viewModel.caption)
	}
	
	private var addPhotoButton: some View {
		Button("Add Photo") {
			FirebaseEventManager.shared.logEvent(name: "addPhotoButton_tapped")
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			viewModel.createPhoto(for: viewModel.plant)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(Color.theme.accentGreen)
	}
	
	private var saveChangesButton: some View {
		Button("Save Changes") {
			FirebaseEventManager.shared.logEvent(name: "saveChangesButton_tapped")
			UIImpactFeedbackGenerator(style: .light).impactOccurred()
			viewModel.saveChanges(for: viewModel.plant)
			dismiss()
		}
		.font(.handjet(.extraBold, size: 20))
		.foregroundStyle(viewModel.captionEdited ? Color.theme.accentGreen : Color.theme.textSecondary.opacity(0.5))
		.disabled(!viewModel.captionEdited)
	}
	
	private var cancelButton: some View {
		Button {
			FirebaseEventManager.shared.logEvent(name: "cancelButton_tapped")
			dismiss()
		} label: {
			Text("Cancel")
				.font(.handjet(.medium, size: 20))
		}
		.foregroundStyle(Color.theme.textSecondary)
	}
}
