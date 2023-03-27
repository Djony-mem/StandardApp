//
//  StandartManager.swift
//  StandardApp
//
//  Created by brubru on 23.03.2023.
//

import Foundation

protocol IStandardManager {
	func getStadium() -> Stadium
}

final class StandardManager {
	private var distance: Distance
	
	init(distance: Distance) {
		self.distance = distance
	}
	
	func getStadium() -> Stadium {
		distance.stadium
	}

	func getHighway() -> Highway {
		distance.highway
	}
	
	
}

extension StandardManager: IStandardManager {
	
}
