	//
	//  MainPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 29.11.2022.
	//

import Foundation



protocol IMainPresenter: AnyObject {
	var standard: Standard! { get }
	func render(gender: Gender)
	func showRegisterVC()
}

class MainPresenter: IMainPresenter {
	weak var view: IMainView?
	let dataManager: IDataManager!
	var standard: Standard!
	var router: IMainRouter?
	
	required init(view: IMainView, dataManager: IDataManager, router: IMainRouter) {
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
	
	func showRegisterVC() {
		router?.route(.register)
	}
	
	private func getStandard() {
		dataManager.getStandard(resorce: "data", type: "json") { standard in
			self.standard = standard
		}
	}
}
