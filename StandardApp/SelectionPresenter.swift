	//
	//  SelectionPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import Foundation


protocol ISelectionPresenter: AnyObject {
	func presentDefaultDischarge()
}

class SelectionPresenter: ISelectionPresenter {
	weak var view: ISelectionView!
	let standardManager: IStandardManager?
	
	private var plase: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	required init(view: ISelectionView, standardManager: IStandardManager) {
		self.view = view
		self.standardManager = standardManager
	}
	
	func presentDefaultDischarge() {
	
	}
	
	
}
