//
//  Note+Extension.swift
//  Seedling
//
//  Created by Laurie Cai on 6/11/24.
//

import Foundation

extension Note {
	
	public var wrappedTitle: String {
		title ?? ""
	}
	
	public var wrappedBody: String {
		body ?? ""
	}
	
	public var wrappedTimestamp: Date {
		timestamp ?? Date()
	}
}
