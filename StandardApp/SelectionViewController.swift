	//
	//  ViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import UIKit

protocol ISelectionView: AnyObject {
	func presentDist(_ dist: Distance)
}

	//MARK: - SelectionViewController
class SelectionViewController: UIViewController {
	
	var presenter: ISelectionPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		createGradient()
		presenter.presentDistance()
	}
	
	func createGradient() {
		
		let primaryColor = UIColor(
			red: 210/255,
			green: 109/255,
			blue: 128/255,
			alpha: 1
		)
		
		let secondaryColor = UIColor(
			red: 107/255,
			green: 148/255,
			blue: 230/255,
			alpha: 1
		)
		view.backgroundColor = .clear
		let gradient = CAGradientLayer()
		gradient.frame = view.bounds
		gradient.colors = [primaryColor.cgColor, secondaryColor.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 0, y: 1)
		view.layer.insertSublayer(gradient, at: 0)
	}
}

	//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {
	func presentDist(_ dist: Distance) {
		print(dist.highway.fifteenKM.firstJunior.title)
	}
}
