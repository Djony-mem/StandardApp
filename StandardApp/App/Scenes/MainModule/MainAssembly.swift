	//
	//  MainAssembly.swift
	//  StandardApp
	//
	//  Created by brubru on 01.12.2022.
	//

import UIKit


final class MainAssembly {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainAssembly: Assemblying {
	func assembly(viewController: UIViewController) {
		guard let mainVC = viewController as? MainViewController else { return }
		let router = MainRouter(navigationController: navigationController)
		let dataManager = DataManager()
		let presenter = MainPresenter(view: mainVC, dataManager: dataManager, router: router)
		
		mainVC.presenter = presenter
	}
}

