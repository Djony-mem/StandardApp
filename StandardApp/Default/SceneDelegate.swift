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
    
        let mainListVC = assemblyMainList()
        let navController = UINavigationController(rootViewController: mainListVC)
		MainListAssembly(navigationController: navController).assembly(viewController: mainListVC)
//        MainAssembly(navigationController: navController).assembly(viewController: mainVC)
        window?.rootViewController = navController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }
	
	func assemblyMainList() -> UICollectionViewController {
		let layout = UICollectionViewFlowLayout()
		let mainListVC = MainListViewController(collectionViewLayout: layout)
		return mainListVC
	}
	
	func assemblyMain() -> UIViewController {
		MainListViewController()
	}
}

