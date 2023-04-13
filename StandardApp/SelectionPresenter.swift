	//
	//  SelectionPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import Foundation


protocol ISelectionPresenter: AnyObject {
	func changedSwitchValue(_ isOn: Bool)
	func changeSwitchValueForColor(_ isOn: Bool)
	func changeSwithForPlace(_ isOn: Bool)
	func changedPickerDistans(stadium: StadiumEnum)
	func circleLengthMenuAction(circleEnum: CircleEnum)
	func timingMenuManualAction(cronometer: ChronometerEnum)
	func renderd(time: Time)
}

class SelectionPresenter: ISelectionPresenter {
	weak var viewController: ISelectionView!
	let standardManager: IStandardManager
	let router: ISelectionRouter
	
	private var place: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	required init(view: ISelectionView, standardManager: IStandardManager, router: ISelectionRouter) {
		self.viewController = view
		self.standardManager = standardManager
		self.router = router
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
	
	func circleLengthMenuAction(circleEnum: CircleEnum) {
		circleLength = circleEnum
	}
	
	func timingMenuManualAction(cronometer: ChronometerEnum) {
		self.chronometer = cronometer
	}
	
	func renderd(time: Time) {
		let result: TimeInfo?
		
		switch place {
		case .stadium:
			result = standardManager.getDischarge(chronometer: chronometer, stadium: stadium, circleLength: circleLength, time: time)
			print(result?.imageRank)
		case .highway:
			result = standardManager.getHighwayDistans(highway, userTime: time)
			print(result?.imageRank)
		}
		
		
	}
	
}
