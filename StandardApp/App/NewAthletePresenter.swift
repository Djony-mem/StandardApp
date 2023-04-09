//
//  NewAthletePresenter.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import Foundation

protocol INewAthletePresenter {
	
}

final class NewAthletePresenter {
	weak var view: INewAthleteView?
	var router: INewAthleteRouter?
	
	private var gender: Gender = .male
	private var nikName = "Атлет"
	
	init(view: INewAthleteView, router: INewAthleteRouter) {
		self.view = view
		self.router = router
	}
	
	func chooseGender(_ gender: Gender) {
		self.gender = gender
	}
	
	func enteredNikName(_ nikName: String) {
		self.nikName = nikName
	}
	
	func sendViewModel() {
		let viewModel = ViewModel(nikName: nikName, gender: gender)
		router?.route(.mainList(viewModel: viewModel))
	}
}

extension NewAthletePresenter: INewAthletePresenter {
	
}
