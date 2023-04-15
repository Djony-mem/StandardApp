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
	private weak var view: IMainListView?
	private let dataManager: IDataManager!
	private let router: IMainListRouter?
	var athlets = [Athlete]()
	
	var standard: Standard!
	
	
	required init(view: IMainListView, dataManager: IDataManager, router: IMainListRouter) {
		self.view = view
		self.dataManager = dataManager
		self.router = router
		getStandard()
	}
	
	func render(gender: Gender) {
		print("Gender \(gender.rawValue)")
		switch gender {
		case .male:
//			let athlete = Athlete(nikName: <#T##String#>, gender: <#T##Gender#>, results: <#T##[TimeResult]?#>)
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
