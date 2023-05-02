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
	private let isHidden: Bool
	
	init(timeResult: TimeResult, navigationViewController: UINavigationController, isHidden: Bool) {
		self.timeResult = timeResult
		self.navigationViewController = navigationViewController
		self.isHidden = isHidden
	}
}

extension ResultAssembly: Assemblying {
	func configur(viewController: UIViewController) {
		let resultVC = viewController as? ResultViewController
		let router = ResultRouter(navigationController: navigationViewController)
		print("Hi Assembly \(timeResult.date)")
		let presenter = ResultPresenter(view: resultVC, router: router, timeResult: timeResult, isHidden: isHidden)
		
		resultVC?.presenter = presenter
	}
}
