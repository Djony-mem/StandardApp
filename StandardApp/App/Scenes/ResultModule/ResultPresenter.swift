	//
	//  ResultPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 10.04.2023.
	//

import Foundation

struct ViewModelResult {
	let distance: String
	let userTime: String
	let imageRank: String
	let userRank: String
	let allRank: String
	let record: RecordBreaker
}

struct RecordBreaker {
	let fullName: String
	let time: String
	let recordDate: String
}

protocol IResultPresenter {
	func isHiddenButton()
	func render()
	func dismissActiion()
}

final class ResultPresenter {
	private weak var view: IResultView!
	private let router: IResultRouter
	private let timeResult: TimeResult
	private let isHidden: Bool
	
	init(view: IResultView!, router: IResultRouter, timeResult: TimeResult, isHidden: Bool) {
		self.view = view
		self.router = router
		self.timeResult = timeResult
		self.isHidden = isHidden
	}
}

extension ResultPresenter: IResultPresenter {
	func isHiddenButton() {
		view.isHeaderButton(isHidden)
	}
	
	func render() {
		let viewModel = ViewModelResult(
			distance: timeResult.distance,
			userTime: timeResult.userTime.separatedString(),
			imageRank: timeResult.imageRank,
			userRank: timeResult.userRank,
			allRank: """
 МСМК:					\(timeResult.allRank.msmk.separatedString())
 МС:						\(timeResult.allRank.ms.separatedString())
 КМС:						\(timeResult.allRank.kms.separatedString())
 Первый разряд:			\(timeResult.allRank.firstRank.separatedString())
 Второй разряд:			\(timeResult.allRank.secondRank.separatedString())
 Третий разряд:			\(timeResult.allRank.thirdRank.separatedString())
 Первый юношеский:		\(timeResult.allRank.firstJunior.separatedString())
 Второй юнешеский: 		\(timeResult.allRank.secondJunior.separatedString())
 Третий юнешеский: 		\(timeResult.allRank.thirdJunior.separatedString())
 """,
			record: RecordBreaker(
				fullName: timeResult.allRank.recordHolder.fullName,
				time: timeResult.allRank.recordHolder.time.separatedString(),
				recordDate: timeResult.allRank.recordHolder.recordDate)
		)
		
		view.render(viewModel: viewModel)
	}
	
	func dismissActiion() {
		router.route(.selection)
	}
}
