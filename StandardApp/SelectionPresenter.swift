	//
	//  SelectionPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import Foundation

protocol ISelectionPresenter: AnyObject {
	func sendTitle()
	func sendBGImage()
	func changedSwitchValue(_ isOn: Bool)
	func changeSwitchValueForColor(_ isOn: Bool)
	func changeSwithForPlace(_ isOn: Bool)
	func changedPickerDistans(stadium: StadiumEnum)
	func changedPickerDistans(highway: HighwayEnum)
	func circleLengthMenuAction(circleEnum: CircleEnum)
	func timingMenuManualAction(cronometer: ChronometerEnum)
	func renderd(time: Time)
	func didTapBarButton()
	
	func saveTimeResult()
}

final class SelectionPresenter {
	let standardManager: IStandardManager
	let storageManager: IStorageManager
	var timeResult: TimeResult!
	var athlete: Athlete!
	
	private weak var viewController: ISelectionView!
	private let router: ISelectionRouter
	
	private var place: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	required init(athlet: Athlete,
				  view: ISelectionView,
				  standardManager: IStandardManager,
				  router: ISelectionRouter,
				  storage: IStorageManager) {
		self.athlete = athlet
		self.viewController = view
		self.standardManager = standardManager
		self.storageManager = storage
		self.router = router
	}
	
}

extension SelectionPresenter: ISelectionPresenter {
	func sendTitle() {
		viewController.setuptitle(athlete.nikName ?? "")
	}
	
	func sendBGImage() {
		let image = athlete.gender == Gender.male.rawValue ? "opacityM" : "opacityW"
		viewController.setupBgGender(image: image)
	}
	
	func changedSwitchValue(_ isOn: Bool) {
		let text = isOn ? "Шоссе" : "Стадион"
		viewController.changeSwitchLabel(text: text)
	}
	
	func changeSwitchValueForColor(_ isOn: Bool) {
		let colorForBorder = isOn
		? ColorSpace.ActiveElement.notEnebled
		: ColorSpace.ActiveElement.enebled
		
		viewController.changeColor(colorForBorder)
	}
	
	func changeSwithForPlace(_ isOn: Bool) {
		place = isOn ? .highway : .stadium
	}
	
	func changedPickerDistans(stadium: StadiumEnum) {
		self.stadium = stadium
	}
	
	func changedPickerDistans(highway: HighwayEnum) {
		self.highway = highway
	}
	
	func circleLengthMenuAction(circleEnum: CircleEnum) {
		circleLength = circleEnum
	}
	
	func timingMenuManualAction(cronometer: ChronometerEnum) {
		self.chronometer = cronometer
	}
	
	func renderd(time: Time) {
		let result: (timeInfo: TimeInfo?,discharge: Discharge?)
		let distance: String
		
		switch place {
		case .stadium:
			result = standardManager.getDischarge(
				chronometer: chronometer,
				stadium: stadium,
				circleLength: circleLength, time: time
			)
			distance = stadium.rawValue
		case .highway:
			result = standardManager.getHighwayDistans(
				highway,
				userTime: time
			)
			distance = highway.rawValue
		}
		
		storageManager.createTimeResult(distance: distance,
										timeInfo: result.timeInfo,
										discharge: result.discharge) { timeResult in
			self.timeResult = timeResult
		}
		
		router.route(.result(timeResult: timeResult, isHidden: false))
	}
	
	func didTapBarButton() {
		router.route(.progressList(athlete: athlete, storage: storageManager))
	}
	
	func saveTimeResult() {
		storageManager.saveTimeResult(athlete: athlete, timeResult: timeResult)
	}
	
}
