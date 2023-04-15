//
//  SelectionAssembly.swift
//  StandardApp
//
//  Created by brubru on 01.12.2022.
//

import UIKit

//MARK: - SelectionAssembly
final class SelectionAssembly {

    //MARK: - Private Property
    private let navigationController: UINavigationController
    private let distance: Distance
	private let athlete: Athlete
    
    //MARK: - Initializer
    init(distance: Distance, athlete: Athlete, navigationController: UINavigationController) {
        self.distance = distance
		self.athlete = athlete
        self.navigationController = navigationController
    }
}


//MARK: - Assemblying
extension SelectionAssembly: Assemblying {
    func configur(viewController: UIViewController) {
        guard let selectionVC = viewController as? SelectionViewController else { return }
		let standardManager = StandardManager(distance: distance)
		let router = SelectionRouter(navigationController: navigationController)
		let presenter = SelectionPresenter(athlet: athlete, view: selectionVC, standardManager: standardManager, router: router)
        selectionVC.presenter = presenter
    }
}
