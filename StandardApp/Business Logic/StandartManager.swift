	//
	//  StandartManager.swift
	//  StandardApp
	//
	//  Created by brubru on 23.03.2023.
	//

import Foundation

protocol IStandardManager {
	func getHighwayDistans(_ highwayEnum: HighwayEnum, userTime: Time) -> TimeInfo?
	func getDischarge(chronometer: ChronometerEnum, stadium: StadiumEnum, circleLength: CircleEnum, time: Time) -> TimeInfo?
}

final class StandardManager {
	private var distance: Distance
	
	init(distance: Distance) {
		self.distance = distance
	}
	
	func getHighwayDistans(_ highwayEnum: HighwayEnum, userTime: Time) -> TimeInfo? {
		let highway = getHighway()
		
		switch highwayEnum {
		case .oneHundredKM:
			return getResult(discharge: highway.oneHundredKM, userTime: userTime)
		case .marathon:
			return getResult(discharge: highway.marathon, userTime: userTime)
		case .halfMarathon:
			return getResult(discharge: highway.halfMarathon, userTime: userTime)
		case .fifteenKM:
			return getResult(discharge: highway.fifteenKM, userTime: userTime)
		}
	}
	
	func getDischarge(chronometer: ChronometerEnum, stadium: StadiumEnum, circleLength: CircleEnum, time: Time) -> TimeInfo? {
		let chronom = getChronometer(chronometer, stadium: stadium)
		
		if let discharge = chronom.discharge {
			return getResult(discharge: discharge, userTime: time)
		} else if let circle = chronom.circle {
			switch circleLength {
			case .circleLength200:
				let discharge200 = circle.circleLength200
				return getResult(discharge: discharge200, userTime: time)
			case .circleLength400:
				let discharge400 = circle.circleLength400
				return getResult(discharge: discharge400, userTime: time)
			case .none:
				return nil
			}
		}
		return TimeInfo(title: "", time: "", imageRank: "")
	}
	
	private func getChronometer(_ chronometer: ChronometerEnum, stadium: StadiumEnum) -> (discharge: Discharge?, circle: Circle?) {
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
				return (tym.manual, nil)
			}
		}
		return (nil, nil)
	}
	
	private func getStadiumDistans(stadiumEnum: StadiumEnum) -> (
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
	
	private func getStadium() -> Stadium {
		distance.stadium
	}
	
	private func getHighway() -> Highway {
		distance.highway
	}
	
	private func getResult(discharge: Discharge, userTime: Time) -> TimeInfo? {
		
		let msmk = Time(stringLiteral: discharge.msmk.time)
		let ms = Time(stringLiteral: discharge.ms.time)
		let kms = Time(stringLiteral: discharge.kms.time)
		let firstRank = Time(stringLiteral: discharge.firstRank.time)
		let secondRank = Time(stringLiteral: discharge.secondRank.time)
		let thirdRank = Time(stringLiteral: discharge.thirdRank.time)
		let firstJunior = Time(stringLiteral: discharge.firstJunior.time)
		let secondJunior = Time(stringLiteral: discharge.secondJunior.time)
		let thirdJunior = Time(stringLiteral: discharge.thirdJunior.time)
		
		let recordTime = Time(stringLiteral: discharge.recordHolder.time)
		let time = Time(hour: 0, minute: 0, second: 0, millisecond: 0)
		
		if userTime <= recordTime && userTime != time {
			return TimeInfo(
				title: "Вы побили рекорд \(discharge.recordHolder.fullName)",
				time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
				imageRank: "record"
			)
		}
		
		
		if userTime <= msmk {
			if msmk == time {
				return getDefaultTimeInfo()
			}
			return discharge.msmk
		} else if userTime <= ms && ms != time {
			return  discharge.ms
		} else if userTime <= kms && kms != time {
			return discharge.kms
		} else if userTime <= firstRank && firstRank != time {
			return discharge.firstRank
		} else if userTime <= secondRank && secondRank != time {
			return discharge.secondRank
		} else if userTime <= thirdRank && thirdRank != time {
			return discharge.thirdRank
		} else if userTime <= firstJunior && firstJunior != time {
			return discharge.firstJunior
		} else if userTime <= secondJunior && secondJunior != time {
			return discharge.secondJunior
		} else if userTime <= thirdJunior && thirdJunior != time {
			return discharge.thirdJunior
		} else if userTime > thirdJunior && thirdJunior != time {
			return TimeInfo(
				title: "Любитель",
				time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
				imageRank: "amateurM"
			)
		} else {
			if firstJunior == time && userTime > thirdRank {
				return TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
			} else if secondJunior == time && userTime > thirdRank {
				return TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
			} else if thirdJunior == time && userTime > thirdRank {
				return TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
			} else {
				return getDefaultTimeInfo()
			}
		}
	}
	
	private func getDefaultTimeInfo() -> TimeInfo {
		return TimeInfo(
			title: "Для внесенных параметров не предусмотрен разряд",
			time: "00:00:00:00",
			imageRank: "AppIcon"
		)
	}
}

extension StandardManager: IStandardManager {}
