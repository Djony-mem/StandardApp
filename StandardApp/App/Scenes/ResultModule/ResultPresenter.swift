	//
	//  ResultPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 10.04.2023.
	//

import Foundation

struct ViewModelResult {
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
	func render()
	func dismissActiion()
}

final class ResultPresenter {
	private weak var view: IResultView!
	private let router: IResultRouter
	private let timeResult: TimeResult
	
	init(view: IResultView!, router: IResultRouter, timeResult: TimeResult) {
		self.view = view
		self.router = router
		self.timeResult = timeResult
	}
}

extension ResultPresenter: IResultPresenter {
	func render() {
		let viewModel = ViewModelResult(
			userTime: separatedString(value: timeResult.userTime),
			imageRank: timeResult.imageRank,
			userRank: timeResult.userRank,
			allRank: """
 МСМК:					\(separatedString(value: timeResult.allRank.msmk))
 МС:						\(separatedString(value: timeResult.allRank.ms))
 КМС:						\(separatedString(value: timeResult.allRank.kms))
 Первый разряд:			\(separatedString(value: timeResult.allRank.firstRank))
 Второй разряд:			\(separatedString(value: timeResult.allRank.secondRank))
 Третий разряд:			\(separatedString(value: timeResult.allRank.thirdRank))
 Первый юношеский:		\(separatedString(value: timeResult.allRank.firstJunior))
 Второй юнешеский: 		\(separatedString(value: timeResult.allRank.secondJunior))
 Третий юнешеский: 		\(separatedString(value: timeResult.allRank.thirdJunior))
 """,
			record: RecordBreaker(
				fullName: timeResult.allRank.recordHolder.fullName,
				time: separatedString(value: timeResult.allRank.recordHolder.time),
				recordDate: timeResult.allRank.recordHolder.recordDate)
		)
		
		view.render(viewModel: viewModel)
	}
	
	func dismissActiion() {
		router.route(.selection)
	}
	
	private func separatedString(value: String) -> String {
		let components = value.components(separatedBy: ":").map { Int($0) ?? 0 }
		if components[0] == 0 && components[1] == 0 && components[2] == 0 {
			return "--"
		} else if components[0] == 0 && components[1] == 0 {
			return "\(components[2]),\(String(format: "%02d", components[3]))"
		} else if components[0] == 0 {
			return "\(String(format: "%02d", components[1])):\(String(format: "%02d", components[2])),\(String(format: "%02d", components[3]))"
		}
		return "\(components[0]):\(String(format: "%02d", components[1])):\(String(format: "%02d", components[2])),\(String(format: "%02d", components[3]))"
	}
}
