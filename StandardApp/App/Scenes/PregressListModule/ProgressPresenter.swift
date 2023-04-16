//
//  ProgressPresenter.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import Foundation

protocol IProgressPresenter {
	
}

final class ProgressPresenter {
	private weak var viewList: IProgressList!
	var router: IProgressRouter
	
	init(viewList: IProgressList, router: IProgressRouter) {
		self.viewList = viewList
		self.router = router
	}
}

extension ProgressPresenter: IProgressPresenter {
	
}
