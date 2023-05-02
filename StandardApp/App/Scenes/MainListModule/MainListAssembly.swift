//
//  MainListAssembly.swift
//  StandardApp
//
//  Created by brubru on 08.04.2023.
//

import UIKit

final class MainListAssembly {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainListAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		guard let mainListVC = viewController as? MainListViewController else { return }
		let dataManager = DataManager()
		let storageManager = StorageManager()
		let router = MainListRouter(navigationController: navigationController, storage: storageManager)
		let presenter = MainListPresenter(view: mainListVC, dataManager: dataManager, router: router, storage: storageManager)
		
		mainListVC.presenter = presenter
	}
}
