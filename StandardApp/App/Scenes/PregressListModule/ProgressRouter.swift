//
//  ProgressRouter.swift
//  StandardApp
//
//  Created by brubru on 15.04.2023.
//

import UIKit

protocol IProgressRouter {
	func route(_ target: ProgressRouter.Target)
}

final class ProgressRouter {
	enum Target {
		case result(timeResult: TimeResult)
		case selection
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension ProgressRouter: IProgressRouter {
	func route(_ target: Target) {
		switch target {
		case .result(let timeResult):
			let resultVC = ResultViewController()
			let resultAssembly = ResultAssembly(
				timeResult: timeResult,
				navigationViewController: navigationController
			)
			resultAssembly.configur(viewController: resultVC)
			let neededVC = navigationController.viewControllers.filter { $0 is ISelectionView }.first
			neededVC?.present(resultVC, animated: true)
		case .selection:
			break
		}
	}
}
