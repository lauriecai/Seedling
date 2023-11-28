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
	let backgroundAlt = Color("ColorBackgroundAlt")
	let backgroundAlt2 = Color("ColorBackgroundAlt2")
	let backgroundAccent = Color("ColorBackgroundAccent")
	
	let textPrimary = Color("ColorTextPrimary")
	let textSecondary = Color("ColorTextSecondary")
	let textAlt = Color("ColorTextAlt")
	
}
