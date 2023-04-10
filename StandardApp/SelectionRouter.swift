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
		case result
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
		case .result:
			break
		case .progressList:
			break
		}
	}
}
