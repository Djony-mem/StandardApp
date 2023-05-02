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
	private let timeResults: Set<TimeResult>
	
	
	init(timeResults: Set<TimeResult>, viewList: IProgressList, router: IProgressRouter) {
		self.timeResults = timeResults
		self.viewList = viewList
		self.router = router
	}
}

extension ProgressPresenter: IProgressPresenter {
	func didSelecterRow(indexPath: IndexPath) {
		let sortedResult = timeResults.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
		router.route(.result(timeResult: sortedResult[indexPath.row], isHidden: true))
	}
	
	func sendTitle() {
//		viewList.setuptitle(athlete.nikName)
	}
	
	func fetchData() {
		var progressViewModels = [ViewModelProgress]()
		let sortedResult = timeResults.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
		
		sortedResult.forEach { timeResult in
			let viewModel = ViewModelProgress(
				distance: timeResult.distance ?? "",
				date: timeResult.date ?? Date(),
				userTime: timeResult.userTime?.separatedString() ?? "",
				userRank: timeResult.userRank ?? "",
				imageRank: timeResult.imageRank ?? ""
			)
			progressViewModels.append(viewModel)
		}
		
		viewList.render(viewData: progressViewModels)
	}
}
