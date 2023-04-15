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
	
	func transform(viewModel: ViewModel)
	func render(index: IndexPath)
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
	
	func transform(viewModel: ViewModel) {
		let athlete = Athlete(nikName: viewModel.nikName, gender: viewModel.gender, timeResults: [])
		athlets.append(athlete)
	}
	
	func render(index: IndexPath) {
		let athlete = athlets[index.row]
		switch athlete.gender {
		case .male:
			router?.route(.selection(distance: standard.man, athlete: athlete))
		case .fimale:
			router?.route(.selection(distance: standard.woman,  athlete: athlete))
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
