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

final class SelectionPresenter: ISelectionPresenter {
	private weak var viewController: ISelectionView!
	private let router: ISelectionRouter
	let standardManager: IStandardManager
	var timeResult: TimeResult!
	var athlet: Athlete!
	
	private var place: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	required init(athlet: Athlete, view: ISelectionView,
				  standardManager: IStandardManager,
				  router: ISelectionRouter) {
		self.athlet = athlet
		self.viewController = view
		self.standardManager = standardManager
		self.router = router
	}
	
	func sendTitle() {
		viewController.setuptitle(athlet.nikName)
	}
	
	func sendBGImage() {
		let image = athlet.gender == .male ? "opacityM" : "opacityW"
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
		
		switch place {
		case .stadium:
			result = standardManager.getDischarge(
				chronometer: chronometer,
				stadium: stadium,
				circleLength: circleLength, time: time
			)
		case .highway:
			result = standardManager.getHighwayDistans(
				highway,
				userTime: time
			)
		}
		
		timeResult = TimeResult(
			userTime: result.timeInfo?.time ?? "",
			userRank: result.timeInfo?.title ?? "",
			imageRank: result.timeInfo?.imageRank ?? "",
			allRank: Rank(
				msmk: result.discharge?.msmk.time ?? "",
				ms: result.discharge?.ms.time ?? "",
				kms: result.discharge?.kms.time ?? "",
				firstRank: result.discharge?.firstRank.time ?? "",
				secondRank: result.discharge?.secondRank.time ?? "",
				thirdRank: result.discharge?.thirdRank.time ?? "",
				firstJunior: result.discharge?.firstJunior.time ?? "",
				secondJunior: result.discharge?.secondJunior.time ?? "",
				thirdJunior: result.discharge?.thirdJunior.time ?? "",
				recordHolder: Record(
					fullName: result.discharge?.recordHolder.fullName ?? "",
					time: result.discharge?.recordHolder.time ?? "",
					recordDate: result.discharge?.recordHolder.recordDate ?? ""
				)
			)
		)
		router.route(.result(timeResult: timeResult))
	}
	
	func didTapBarButton() {
		router.route(.progressList(timeResults: athlet.timeResults ?? []))
	}
	
	func saveTimeResult() {
		athlet.timeResults?.append(timeResult)
	}
}
