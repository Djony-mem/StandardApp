//
//  SelectionRouter.swift
//  StandardApp
//
//  Created by brubru on 09.04.2023.
//

import UIKit

protocol ISelectionRouter {
	func route(_ target: SelectionRouter.Target)
}

final class SelectionRouter {
	enum Target {
		case result(timeInfo: TimeInfo)
		case progressList
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension SelectionRouter: ISelectionRouter {
	func route(_ target: Target) {
		switch target {
		case .result(let timeInfo):
			let resultVC = ResultViewController()
			let resultAssembly = ResultAssembly(timeInfo: timeInfo, navigationViewController: navigationController)
			resultAssembly.configur(viewController: resultVC)
			let neededVC = navigationController.viewControllers.filter { $0 is ISelectionView }.first
			neededVC?.present(resultVC, animated: true)
		case .progressList:
			break
		}
	}
}
