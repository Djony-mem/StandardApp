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
		case result(timeResult: TimeResult, isHidden: Bool)
		case progressList(timeResults: Set<TimeResult>)
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension SelectionRouter: ISelectionRouter {
	func route(_ target: Target) {
		switch target {
		case let .result(timeResult, isHidden):
			let resultVC = ResultViewController()
			let resultAssembly = ResultAssembly(
				timeResult: timeResult,
				navigationViewController: navigationController,
				isHidden: isHidden
			)
			resultAssembly.configur(viewController: resultVC)
			let neededVC = navigationController.viewControllers.filter { $0 is ISelectionView }.first
			neededVC?.present(resultVC, animated: true)
		case .progressList(let timeResults):
			let progressList = ProgressListViewController()
			let progressAssembly = ProgressAssembly(
				timeResults: timeResults,
				navigationController: navigationController
			)
			progressAssembly.configur(viewController: progressList)
			navigationController.pushViewController(progressList, animated: true)
		}
	}
}
