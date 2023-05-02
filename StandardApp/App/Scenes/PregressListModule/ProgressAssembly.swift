//
//  ProgressAssembly.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import UIKit

final class ProgressAssembly {
	private let timeResults: Set<TimeResult>
	private let navigationController: UINavigationController
	
	init(timeResults: Set<TimeResult>, navigationController: UINavigationController) {
		self.timeResults = timeResults
		self.navigationController = navigationController
	}
}

extension ProgressAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		guard let progressList = viewController as? ProgressListViewController else { return }
		let router = ProgressRouter(navigationController: navigationController)
		let presenter = ProgressPresenter(timeResults: timeResults, viewList: progressList, router: router)
		
		progressList.presenter = presenter
	}
}
