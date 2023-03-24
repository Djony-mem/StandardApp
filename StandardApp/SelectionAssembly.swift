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
    
    //MARK: - Initializer
    init(distance: Distance, navigationController: UINavigationController) {
        self.distance = distance
        self.navigationController = navigationController
    }
}


//MARK: - Assemblying
extension SelectionAssembly: Assemblying {
    func assembly(viewController: UIViewController) {
        guard let selectionVC = viewController as? SelectionViewController else { return }
		let standardManager = StandardManager(distance: distance)
        let presenter = SelectionPresenter(view: selectionVC, standardManager: standardManager)
        selectionVC.presenter = presenter
    }
}
