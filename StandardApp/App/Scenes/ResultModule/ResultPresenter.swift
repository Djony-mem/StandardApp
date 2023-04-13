//
//  ResultPresenter.swift
//  StandardApp
//
//  Created by brubru on 10.04.2023.
//

import Foundation

struct ViewModelResult {
	let image: String
	let time: String
	let rank: String
}

protocol IResultPresenter {
	func render()
}

final class ResultPresenter {
	private weak var view: IResultView!
	private let router: IResultRouter
	private let timeInfo: TimeInfo
	
	init(view: IResultView!, router: IResultRouter, timeInfo: TimeInfo) {
		self.view = view
		self.router = router
		self.timeInfo = timeInfo
	}
	
	func render() {
		let viewModel = ViewModelResult(
			image: timeInfo.imageRank ?? "",
			time: timeInfo.time,
			rank: timeInfo.title
		)
		view.render(viewModel: viewModel)
	}
}

extension ResultPresenter: IResultPresenter {
	
}
