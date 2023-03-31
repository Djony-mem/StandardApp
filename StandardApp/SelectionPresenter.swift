	//
	//  SelectionPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import Foundation


protocol ISelectionPresenter: AnyObject {
	func changedSwitchValue(_ isOn: Bool)
}

class SelectionPresenter: ISelectionPresenter {
	weak var viewController: ISelectionView!
	let standardManager: IStandardManager?
	
	private var plase: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	required init(view: ISelectionView, standardManager: IStandardManager) {
		self.viewController = view
		self.standardManager = standardManager
	}
	
	func changedSwitchValue(_ isOn: Bool) {
		let text = isOn ? "Шоссе" : "Стадион"
		viewController.changeSwitchLabel(text: text)
	}
	
}
