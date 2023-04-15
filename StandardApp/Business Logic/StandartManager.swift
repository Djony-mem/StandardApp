	//
	//  StandartManager.swift
	//  StandardApp
	//
	//  Created by brubru on 23.03.2023.
	//

import Foundation

protocol IStandardManager {
	func getHighwayDistans(_ highwayEnum: HighwayEnum, userTime: Time) -> (timeInfo: TimeInfo?, discharge: Discharge?)
	func getDischarge(chronometer: ChronometerEnum, stadium: StadiumEnum, circleLength: CircleEnum, time: Time) -> (timeInfo: TimeInfo?, discharge: Discharge?)
}

final class StandardManager {
	private var distance: Distance
	
	init(distance: Distance) {
		self.distance = distance
	}
	
	func getHighwayDistans(_ highwayEnum: HighwayEnum, userTime: Time) -> (timeInfo: TimeInfo?, discharge: Discharge?)  {
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
	
	func getDischarge(chronometer: ChronometerEnum, stadium: StadiumEnum, circleLength: CircleEnum, time: Time) -> (timeInfo: TimeInfo?, discharge: Discharge?) {
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
				return (nil, nil)
			}
		}
		return (nil, nil)
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
	
	private func getResult(discharge: Discharge, userTime: Time) -> (timeInfo: TimeInfo?, discharge: Discharge) {
		
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
			let timeInfo = TimeInfo(
				title: "Вы побили рекорд \(discharge.recordHolder.fullName)",
				time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
				imageRank: "record"
			)
			return (timeInfo, discharge)
		}
		
		
		if userTime <= msmk, ms != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.msmk.title,
				time: userTime,
				image: discharge.msmk.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= ms && ms != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.ms.title,
				time: userTime,
				image: discharge.ms.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= kms && kms != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.kms.title,
				time: userTime,
				image: discharge.kms.imageRank ?? ""
			)
			print("KMSW \(timeInfo.imageRank)")
			return (timeInfo, discharge)
		} else if userTime <= firstRank && firstRank != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.firstRank.title,
				time: userTime,
				image: discharge.firstRank.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= secondRank && secondRank != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.secondRank.title,
				time: userTime,
				image: discharge.secondRank.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= thirdRank && thirdRank != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.thirdRank.title,
				time: userTime,
				image: discharge.thirdRank.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= firstJunior && firstJunior != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.firstJunior.title,
				time: userTime,
				image: discharge.firstJunior.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= secondJunior && secondJunior != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.secondJunior.title,
				time: userTime,
				image: discharge.secondJunior.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime <= thirdJunior && thirdJunior != time {
			let timeInfo = getUserTimeInfo(
				title: discharge.thirdJunior.title,
				time: userTime,
				image: discharge.thirdJunior.imageRank ?? ""
			)
			return (timeInfo, discharge)
		} else if userTime > thirdJunior && thirdJunior != time {
			let timeInfo = TimeInfo(
				title: "Любитель",
				time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
				imageRank: "amateurM"
			)
			return (timeInfo, discharge)
		} else {
			if firstJunior == time && userTime > thirdRank {
				let timeInfo = TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
				return (timeInfo, discharge)
			} else if secondJunior == time && userTime > thirdRank {
				let timeInfo = TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
				return (timeInfo, discharge)
			} else if thirdJunior == time && userTime > thirdRank {
				let timeInfo = TimeInfo(
					title: "Любитель",
					time: "\(userTime.hour):\(userTime.minute):\(userTime.second):\(userTime.millisecond)",
					imageRank: "amateurM"
				)
				return (timeInfo, discharge)
			} else {
				let timeInfo = getDefaultTimeInfo()
				return (timeInfo, discharge)
			}
		}
	}
	
	private func getUserTimeInfo(title: String, time: Time, image: String) -> TimeInfo {
		TimeInfo(
			title: title,
			time: "\(time.hour):\(time.minute):\(time.second):\(time.millisecond)",
			imageRank: image
		)
	}
	
	private func getDefaultTimeInfo() -> TimeInfo {
		return TimeInfo(
			title: "Не корректные данные",
			time: "00:00:00:00",
			imageRank: "bothAmat"
		)
	}
}

extension StandardManager: IStandardManager {}
