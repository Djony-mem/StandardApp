//
//  NewAthleteRouter.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import UIKit

protocol INewAthleteRouter {
	func route(_ target: NewAthleteRouter.Target)
}

final class NewAthleteRouter {
	
	enum Target {
		case mainList(viewModel: ViewModel)
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension NewAthleteRouter: INewAthleteRouter {
	func route(_ target: Target) {
		switch target {
		case .mainList(viewModel: let viewModel):
			let neededVC = navigationController.viewControllers.filter { $0 is IMainListView }.first
			let mainListVC = neededVC as! IMainListView
			mainListVC.replace(viewModel: viewModel)
			neededVC?.dismiss(animated: true)
//			navigationController.popViewController(animated: true)
		}
	}
}
