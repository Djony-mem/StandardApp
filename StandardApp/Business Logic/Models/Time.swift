//
//  Time.swift
//  StandardApp
//
//  Created by brubru on 23.03.2023.
//

import Foundation

struct Time {
	let hour: Int
	let minute: Int
	let second: Int
	let millisecond: Int
}

extension Time: ExpressibleByStringLiteral {
	init(stringLiteral value: String) {
		let components = value.components(separatedBy: ":").map { Int($0) ?? 0 }
		hour = components[0]
		minute = components[1]
		second = components[2]
		millisecond = components[3]
	}
}

extension Time: Comparable {
	static func < (lhs: Time, rhs: Time) -> Bool {
		if lhs.hour < rhs.hour {
			return true
		}
		
		if lhs.hour == rhs.hour {
			if lhs.minute < rhs.minute {
				return true
			} else if lhs.minute == rhs.minute {
				if lhs.second < rhs.second {
					return true
				} else if lhs.second == rhs.second {
					print("\(lhs.millisecond) и \(rhs.millisecond)")
					return lhs.millisecond < rhs.millisecond
				}
			}
		}
		return false
	}
}
