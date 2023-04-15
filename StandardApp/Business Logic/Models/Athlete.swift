//
//  Person.swift
//  StandardApp
//
//  Created by brubru on 09.04.2023.
//

import Foundation

struct Athlete {
	let nikName: String
	let gender: Gender
	var timeResults: [TimeResult]?
}

struct TimeResult {
	let date = Date()
	let userTime: String
	let userRank: String
	let imageRank: String
	let allRank: Rank
}

struct Rank: Codable {
	let msmk: String
	let ms: String
	let kms: String
	let firstRank: String
	let secondRank: String
	let thirdRank: String
	let firstJunior: String
	let secondJunior: String
	let thirdJunior: String
	let recordHolder: Record
}

struct Record: Codable {
	let fullName: String
	let time: String
	let recordDate: String
}
