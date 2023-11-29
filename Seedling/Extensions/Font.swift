//
//  Font.swift
//  Seedling
//
//  Created by Laurie Cai on 11/28/23.
//

import Foundation
import SwiftUI

extension Font {
	
	enum Handjet {
		case regular, medium, bold, extraBold
		
		var value: String {
			switch self {
			case .regular:
				return "Handjet-Regular"
			case .medium:
				return "Handjet-Medium"
			case .bold:
				return "Handjet-Bold"
			case .extraBold:
				return "Handjet-ExtraBold"
			}
		}
	}
	
	static func handjet(_ type: Handjet, size: CGFloat) -> Font {
		return .custom(type.value, size: size)
	}
}
