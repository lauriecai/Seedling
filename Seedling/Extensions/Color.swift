//
//  Color.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import Foundation
import SwiftUI

extension Color {
	
	static let theme = ColorTheme()
	
}

struct ColorTheme {
	
	let backgroundPrimary = Color("ColorBackgroundPrimary")
	let backgroundDark = Color("ColorBackgroundDark")
	let backgroundLight = Color("ColorBackgroundLight")
	let backgroundAccent = Color("ColorBackgroundAccent")
	
	let textPrimary = Color("ColorTextPrimary")
	let textSecondary = Color("ColorTextSecondary")
	let textLight = Color("ColorTextLight")
	
	let accentRed = Color("ColorAccentRed")
	let accentGreen = Color("ColorAccentGreen")
	let accentLightGreen = Color("ColorAccentLightGreen")
	let accentYellow = Color("ColorAccentYellow")
	
}
