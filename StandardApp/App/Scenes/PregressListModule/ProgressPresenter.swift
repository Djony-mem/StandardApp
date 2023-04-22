//
//  ProgressPresenter.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import Foundation

struct ViewModelProgress {
	let distance: String
	let date: Date
	let userTime: String
	let userRank: String
	let imageRank: String
}

protocol IProgressPresenter {
	func sendTitle()
	func fetchData()
	func didSelecterRow(indexPath: IndexPath)
}

final class ProgressPresenter {
	var router: IProgressRouter
	
	private weak var viewList: IProgressList!
	private let athlete: Athlete
	
	
	init(athlete: Athlete, viewList: IProgressList, router: IProgressRouter) {
		self.athlete = athlete
		self.viewList = viewList
		self.router = router
	}
}

extension ProgressPresenter: IProgressPresenter {
	func didSelecterRow(indexPath: IndexPath) {
		router.route(.result(timeResult: athlete.timeResults[indexPath.row]))
	}
	
	func sendTitle() {
		viewList.setuptitle(athlete.nikName)
	}
	
	func fetchData() {
		var progressViewModels = [ViewModelProgress]()
		
		athlete.timeResults.forEach { timeResult in
			let viewModel = ViewModelProgress(
				distance: timeResult.distance,
				date: timeResult.date,
				userTime: timeResult.userTime.separatedString(),
				userRank: timeResult.userRank,
				imageRank: timeResult.imageRank
			)
			progressViewModels.append(viewModel)
		}
		
		viewList.render(viewData: progressViewModels)
	}
}
