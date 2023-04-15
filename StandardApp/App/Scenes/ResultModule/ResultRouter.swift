//
//  ResultRouter.swift
//  StandardApp
//
//  Created by brubru on 10.04.2023.
//

import UIKit

protocol IResultRouter {
	func route(_ target: ResultRouter.Target)
}

final class ResultRouter {
	enum Target {
		case selection
	}
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension ResultRouter: IResultRouter {
	func route(_ target: Target) {
		switch target {
		case .selection:
			let neededVC = navigationController.viewControllers.filter { $0 is ISelectionView }.first
			guard let selectionVC = neededVC as? ISelectionView else { return }
			selectionVC.saveTimeResult()
			neededVC?.dismiss(animated: true)
		}
	}
}
