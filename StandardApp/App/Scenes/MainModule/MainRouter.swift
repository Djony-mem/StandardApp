	//
	//  Router.swift
	//  StandardApp
	//
	//  Created by brubru on 01.12.2022.
	//

import UIKit


protocol IMainRouter {
	func route(_ target: MainRouter.Target)
}

final class MainRouter {
	enum Target {
		case selection(distance: Distance)
		case register
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension MainRouter: IMainRouter {
	
	func route(_ target: Target) {
		switch target {
		case .selection(let distance):
			let selectionVC = SelectionViewController()
			SelectionAssembly(distance: distance, navigationController: navigationController).assembly(viewController: selectionVC)
			navigationController.pushViewController(selectionVC, animated: true)
		case .register:
			let registerVC = RegisterViewController()
			navigationController.pushViewController(registerVC, animated: true)
		}
	}
}
