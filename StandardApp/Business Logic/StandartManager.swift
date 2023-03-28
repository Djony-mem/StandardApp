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
	
	func getStadiumDistans(stadiumEnum: StadiumEnum) -> (
		chronom: Chronometer?,
		chronomCircle: ChronometerCircle?,
		tyM: TyM?) {
			
			let stadium = getStadium()
			
			switch stadiumEnum {
			case .tenThousandM:
				return (stadium.tenThousandM, nil, nil)
			case .fiveThousandM:
				return (stadium.fiveThousandM, nil, nil)
			case .threeThousandM:
				return (nil, stadium.threeThousandM, nil)
			case .oneMile:
				return (stadium.oneMile, nil, nil)
			case .fifteenTwoZeroM:
				return (nil, stadium.fifteenTwoZeroM, nil)
			case .oneThousandM:
				return (nil, stadium.oneThousandM, nil)
			case .eightHundredM:
				return (nil, stadium.eightHundredM, nil)
			case .sixHundredM:
				return (nil, stadium.sixHundredM, nil)
			case .fourHundredM:
				return (nil, stadium.fourHundredM, nil)
			case .threeHundredM:
				return (stadium.threeHundredM, nil, nil)
			case .twoHundredM:
				return (nil, stadium.twoHundredM, nil)
			case .oneHundredM:
				return (stadium.oneHundredM, nil, nil)
			case .sixtyM:
				return (stadium.sixtyM, nil, nil)
			case .fiftyM:
				return (nil, nil, stadium.fiftyM)
			case .thirtyM:
				return (nil, nil, stadium.thirtyM)
			}
		}
	
	func getChronometer(_ chronometer: ChronometerEnum, stadium: StadiumEnum) -> (discharge: Discharge?, circle: Circle?) {
		let chronom = getStadiumDistans(stadiumEnum: stadium)
		
		if let chronom = chronom.chronom {
			switch chronometer {
			case .manual:
				return (chronom.manual, nil)
			case .auto:
				return (chronom.auto, nil)
			}
		} else if  let circle = chronom.chronomCircle {
			switch chronometer {
			case .manual:
				return (nil, circle.manual)
			case .auto:
				return (nil, circle.auto)
			}
		} else if let tym = chronom.tyM {
			switch chronometer {
			case .manual:
				return (tym.manual, nil)
			case .auto:
				return (nil, nil)
			}
		}
		return (nil, nil)
	}
	
	func getDischarge(chronometer: ChronometerEnum, stadium: StadiumEnum, circleLength: CircleEnum, time: Time) -> TimeInfo {
		let chronom = getChronometer(chronometer, stadium: stadium)
		
		if let discharge = chronom.discharge {
			
		} else if let circle = chronom.circle {
			switch circleLength {
			case .circleLength200:
				let discharge200 = circle.circleLength200
				
			case .circleLength400:
				let discharge200 = circle.circleLength400
			case .none:
				break
			}
		}
	}
}

extension StandardManager: IStandardManager {}
