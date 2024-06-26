//
//  Standard.swift
//  StandardApp
//
//  Created by brubru on 26.11.2022.
//

import Foundation

// MARK: - Standard
struct Standard: Codable {
    let woman: Distance
    let man: Distance
}

// MARK: - Man
struct Distance: Codable {
    let stadium: Stadium
    let highway: Highway
}

// MARK: - Highway
struct Highway: Codable {
    let oneHundredKM: Discharge
    let marathon: Discharge
    let halfMarathon: Discharge
    let fifteenKM: Discharge
}

// MARK: - Stadium
struct Stadium: Codable {
    let tenThousandM: Chronometer
    let fiveThousandM: Chronometer
    let threeThousandM: ChronometerCircle
    let oneMile: Chronometer
    let fifteenTwoZeroM, oneThousandM, eightHundredM, sixHundredM: ChronometerCircle
    let fourHundredM: ChronometerCircle
    let threeHundredM: Chronometer
    let twoHundredM: ChronometerCircle
    let oneHundredM: Chronometer
    let sixtyM: Chronometer
    let fiftyM, thirtyM: TyM
}

// MARK: - ChronometerCircle
struct ChronometerCircle: Codable {
    let manual: Circle
    let auto: Circle
}

// MARK: - FiveThousandM
struct Chronometer: Codable {
	let manual: Discharge
	let auto: Discharge
}

// MARK: - TyM
struct TyM: Codable {
	let manual: Discharge
}

// MARK: - Circle
struct Circle: Codable {
    let circleLength200:  Discharge
    let circleLength400: Discharge
}



// MARK: - Discharge
struct Discharge: Codable {
    let msmk: TimeInfo
    let ms: TimeInfo
    let kms: TimeInfo
    let firstRank: TimeInfo
    let secondRank: TimeInfo
    let thirdRank: TimeInfo
    let firstJunior: TimeInfo
    let secondJunior: TimeInfo
    let thirdJunior: TimeInfo
	let recordHolder: RecordHolder
}

// MARK: - TimeInfo
struct TimeInfo: Codable {
    let title: String
    let time: String
	let imageRank: String?
}

struct RecordHolder: Codable {
	let fullName: String
	let time: String
	let recordDate: String
}
