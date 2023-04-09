//
//  RegisterAssembly.swift
//  StandardApp
//
//  Created by brubru on 26.12.2022.
//

import UIKit

//MARK: - RegisterAssemply
final class NewAthleteAssemply {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension NewAthleteAssemply {
	func assembly(viewController: UIViewController) {
		guard let newAthleteVC = viewController as? NewAthleteViewController else { return }
		let router = NewAthleteRouter(navigationController: navigationController)
		let presenter = NewAthletePresenter(view: newAthleteVC, router: router)
		
		newAthleteVC.presenter = presenter
	}
}
