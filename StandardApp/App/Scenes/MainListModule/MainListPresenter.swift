//
//  MainListPresenter.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import Foundation

struct ViewModel {
	let nikName: String
	let gender: Gender
}

protocol IMainListPresenter: AnyObject {
	var standard: Standard! { get }
	func render(gender: Gender)
	func showNewAthleteVC()
}

class MainListPresenter: IMainListPresenter {
	weak var view: IMainListView?
	var standard: Standard!
	
	private let dataManager: IDataManager!
	private var router: IMainListRouter?
	
	required init(view: IMainListView, dataManager: IDataManager, router: IMainListRouter) {
		self.view = view
		self.dataManager = dataManager
		self.router = router
		getStandard()
	}
	
	func render(gender: Gender) {
		switch gender {
		case .male:
			router?.route(.selection(distance: standard.man))
		case .fimale:
			router?.route(.selection(distance: standard.woman))
		}
	}
	
	func showNewAthleteVC() {
		router?.route(.addNewAthlete)
	}
	
	private func getStandard() {
		dataManager.getStandard(resorce: "data", type: "json") { standard in
			self.standard = standard
		}
	}
}
