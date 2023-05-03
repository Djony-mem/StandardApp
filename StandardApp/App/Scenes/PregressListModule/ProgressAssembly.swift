//
//  ProgressAssembly.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import UIKit

final class ProgressAssembly {
	private let athlete: Athlete
	private let storage: IStorageManager
	private let navigationController: UINavigationController
	
	init(athlete: Athlete, storage: IStorageManager, navigationController: UINavigationController) {
		self.athlete = athlete
		self.storage = storage
		self.navigationController = navigationController
	}
}

extension ProgressAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		guard let progressList = viewController as? ProgressListViewController else { return }
		let router = ProgressRouter(navigationController: navigationController)
		let presenter = ProgressPresenter(
			athlete: athlete,
			storageManager: storage,
			viewList: progressList,
			router: router
		)
		
		progressList.presenter = presenter
	}
}
