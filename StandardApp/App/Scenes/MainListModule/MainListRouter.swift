//
//  MainListRouter.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import UIKit

protocol IMainListRouter {
	func route(_ target: MainListRouter.Target)
}

final class MainListRouter {
	enum Target {
		case selection(distance: Distance,
					   athlete: Athlete)
		case addNewAthlete
	}
	
	private let navigationController: UINavigationController
	private let storage: IStorageManager
	
	init(navigationController: UINavigationController, storage: IStorageManager) {
		self.navigationController = navigationController
		self.storage = storage
	}
}

extension MainListRouter: IMainListRouter {
	
	func route(_ target: Target) {
		switch target {
		case let .selection(distance, athlete):
			let selectionVC = SelectionViewController()
			let assemblySelection = SelectionAssembly(distance: distance, athlete: athlete, navigationController: navigationController, storageManager: storage)
			assemblySelection.configur(viewController: selectionVC)
			
			navigationController.pushViewController(selectionVC, animated: true)
		case .addNewAthlete:
			let registerVC = NewAthleteViewController()
			let assemblyNewAthlete = NewAthleteAssemply(navigationController: navigationController)
			assemblyNewAthlete.configur(viewController: registerVC)
			navigationController.topViewController?.present(registerVC, animated: true)
//			navigationController.pushViewController(registerVC, animated: true)
		}
	}
}
