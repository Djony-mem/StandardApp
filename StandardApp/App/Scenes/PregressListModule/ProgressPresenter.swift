//
//  ProgressPresenter.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import Foundation

struct ViewModelProgress {
	let date: Date
	let userTime: String
	let userRank: String
	let imageRank: String
}

protocol IProgressPresenter {
	func fetchData()
}

final class ProgressPresenter {
	var router: IProgressRouter
	
	private weak var viewList: IProgressList!
	private let timeResults: [TimeResult]
	
	
	init(timeResults: [TimeResult], viewList: IProgressList, router: IProgressRouter) {
		self.timeResults = timeResults
		self.viewList = viewList
		self.router = router
	}
}

extension ProgressPresenter: IProgressPresenter {
	func fetchData() {
		var progressViewModels = [ViewModelProgress]()
		
		timeResults.forEach { timeResult in
			let viewModel = ViewModelProgress(
				date: timeResult.date,
				userTime: timeResult.userTime,
				userRank: timeResult.userRank,
				imageRank: timeResult.imageRank
			)
			progressViewModels.append(viewModel)
		}
		
		viewList.render(viewData: progressViewModels)
	}
}
