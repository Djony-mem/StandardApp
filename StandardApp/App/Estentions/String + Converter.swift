//
//  String + Converter.swift
//  StandardApp
//
//  Created by brubru on 21.04.2023.
//

import Foundation

extension String {
	func separatedString() -> String {
		let components = self.components(separatedBy: ":").map { Int($0) ?? 0 }
		if components[0] == 0 && components[1] == 0 && components[2] == 0 {
			return "--"
		} else if components[0] == 0 && components[1] == 0 {
			return "\(components[2]),\(String(format: "%02d", components[3]))"
		} else if components[0] == 0 {
			return "\(String(format: "%02d", components[1])):\(String(format: "%02d", components[2])),\(String(format: "%02d", components[3]))"
		}
		return "\(components[0]):\(String(format: "%02d", components[1])):\(String(format: "%02d", components[2])),\(String(format: "%02d", components[3]))"
	}
}
