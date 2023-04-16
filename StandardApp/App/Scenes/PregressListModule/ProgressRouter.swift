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
		case result
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
		case .result:
			break
		case .selection:
			break
		}
	}
}
