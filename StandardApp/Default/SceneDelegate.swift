//
//  SceneDelegate.swift
//  StandardApp
//
//  Created by brubru on 26.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
		
        window?.rootViewController = assemblyMainList()
		window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }
	
	private func assemblyMainList() -> UINavigationController {
		let layout = UICollectionViewFlowLayout()
		let mainListVC = MainListViewController(collectionViewLayout: layout)
		let navController = UINavigationController(rootViewController: mainListVC)
		MainListAssembly(navigationController: navController).configur(viewController: mainListVC)
		return navController
	}
}

