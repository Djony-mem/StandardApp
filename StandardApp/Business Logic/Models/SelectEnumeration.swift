//
//  SelectEnumeration.swift
//  StandardApp
//
//  Created by brubru on 26.03.2023.
//

import Foundation

enum Place {
	case stadium
	case highway
}

enum StadiumEnum: String, CaseIterable {
	case tenThousandM = "10000 м"
	case fiveThousandM = "5000 м"
	case threeThousandM = "3000 м"
	case oneMile = "1 миля"
	case fifteenTwoZeroM = "1500 м"
	case oneThousandM = "1000 м"
	case eightHundredM = "800"
	case sixHundredM = "600"
	case fourHundredM = "400"
	case threeHundredM = "300"
	case twoHundredM = "200"
	case oneHundredM = "100"
	case sixtyM = "60"
	case fiftyM = "50"
	case thirtyM = "30"
	
	var isOnlyManual: Bool {
		self != .fiftyM && self != .thirtyM
	}
	
	var isCircleLengthOnly200: Bool {
		self != .twoHundredM
	}
	
	var isEnebledCircleLength: Bool {
		self != .tenThousandM && self != .fiveThousandM
		&& self != .oneMile && self != .threeHundredM
		&& self != .oneHundredM && self != .sixtyM
		&& self != .fiftyM && self != .thirtyM
	}
}

enum HighwayEnum: String, CaseIterable {
	case oneHundredKM = "100 км"
	case marathon = "Марафон (42,195 км)"
	case halfMarathon = "Полумарафон (21,0975)"
	case fifteenKM = "15 км"
}

enum ChronometerEnum{
	case manual
	case auto
}

enum CircleEnum {
	case circleLength200
	case circleLength400
	case none
}

enum DischargeEnum {
	case msmk
	case ms
	case kms
	case firstRank
	case secondRank
	case thirdRank
	case firstJunior
	case secondJunior
	case thirdJunior
}
