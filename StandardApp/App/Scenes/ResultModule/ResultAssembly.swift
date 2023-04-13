//
//  ResultAssembly.swift
//  StandardApp
//
//  Created by brubru on 10.04.2023.
//

import UIKit

final class ResultAssembly {
	private let navigationViewController: UINavigationController
	private let timeInfo: TimeInfo
	
	init(timeInfo: TimeInfo, navigationViewController: UINavigationController) {
		self.timeInfo = timeInfo
		self.navigationViewController = navigationViewController
	}
}

extension ResultAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		let resultVC = viewController as? ResultViewController
		let router = ResultRouter(navigationController: navigationViewController)
		let presenter = ResultPresenter(view: resultVC, router: router, timeInfo: timeInfo)
		
		resultVC?.presenter = presenter
	}
}
