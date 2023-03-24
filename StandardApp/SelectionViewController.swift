	//
	//  ViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import UIKit

protocol ISelectionView: AnyObject {
	
}

	//MARK: - SelectionViewController
class SelectionViewController: UIViewController {
	
	var presenter: ISelectionPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupView() {
		view.addGradient()
		presenter.presentDistance()
		
		addSubviews()
		
		addActions()
		
		setupLayout()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func addSubviews() {
		
	}
	
	func addActions() {
		
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupLayout() {
		
	}
}

	//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {

}
