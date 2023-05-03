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
	func deleteTiemResulet(index: Int)
}

final class ProgressPresenter {
	var router: IProgressRouter
	
	private let storageManager: IStorageManager
	private weak var viewList: IProgressList!
	private var athlete: Athlete
	
	init(athlete: Athlete,
		 storageManager: IStorageManager,
		 viewList: IProgressList,
		 router: IProgressRouter) {
		
		self.athlete = athlete
		self.storageManager = storageManager
		self.viewList = viewList
		self.router = router
	}
	
	private func getTimeResults() -> [TimeResult]? {
		let timeResults = athlete.timeResults as? Set<TimeResult>
		return timeResults?.sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
	}
}

extension ProgressPresenter: IProgressPresenter {
	func deleteTiemResulet(index: Int) {
		guard let timeResults = getTimeResults() else { return }
		let timeResult = timeResults[index]
		storageManager.deleteTiemResult(athlete: athlete, timeResult: timeResult)
	}
	
	func didSelecterRow(indexPath: IndexPath) {
		guard let sortedResult = getTimeResults() else { return }
		router.route(.result(timeResult: sortedResult[indexPath.row], isHidden: true))
	}
	
	func sendTitle() {
		viewList.setuptitle(athlete.nikName ?? "")
	}
	
	func fetchData() {
		var progressViewModels = [ViewModelProgress]()
		let sortedResult = getTimeResults()
		
		sortedResult?.forEach { timeResult in
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
