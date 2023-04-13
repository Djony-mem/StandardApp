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
		case selection(distance: Distance)
		case addNewAthlete
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainListRouter: IMainListRouter {
	
	func route(_ target: Target) {
		switch target {
		case .selection(let distance):
			let selectionVC = SelectionViewController()
			let assemblySelection = SelectionAssembly(distance: distance, navigationController: navigationController)
			assemblySelection.configur(viewController: selectionVC)
			
			navigationController.pushViewController(selectionVC, animated: true)
		case .addNewAthlete:
			let registerVC = NewAthleteViewController()
			let assemblyNewAthlete = NewAthleteAssemply(navigationController: navigationController)
			assemblyNewAthlete.assembly(viewController: registerVC)
			navigationController.topViewController?.present(registerVC, animated: true)
//			navigationController.pushViewController(registerVC, animated: true)
		}
	}
}
