//
//  ResultAssembly.swift
//  StandardApp
//
//  Created by brubru on 10.04.2023.
//

import UIKit

final class ResultAssembly {
	private let navigationViewController: UINavigationController
	private let timeResult: TimeResult
	
	init(timeResult: TimeResult, navigationViewController: UINavigationController) {
		self.timeResult = timeResult
		self.navigationViewController = navigationViewController
	}
}

extension ResultAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		let resultVC = viewController as? ResultViewController
		let router = ResultRouter(navigationController: navigationViewController)
		let presenter = ResultPresenter(view: resultVC, router: router, timeResult: timeResult)
		
		resultVC?.presenter = presenter
	}
}
