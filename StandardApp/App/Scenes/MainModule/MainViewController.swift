	//
	//  OneMoreMainViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import SwiftUI

protocol IMainView: AnyObject {
	
}
	// MARK: - MainViewController

final class MainViewController: UIViewController {
	
	var presenter: IMainPresenter!
	
		// MARK: - private Property
	private var manButton = GenderButton(normalStateImage: "man", highlightStateImage: "bigMan")
	private var womanButton = GenderButton(normalStateImage: "women", highlightStateImage: "bigWoman")
	
	private var stackView = UIStackView()
	
	
		// MARK: - Override MainViewController
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
		//MARK: - Actions
	@objc
	private func showSelectionVCWomen() {
		presenter.render(gender: .fimale)
	}
	
	@objc
	private func showSelectionVCMan() {
		presenter.render(gender: .male)
	}
	
	@objc
	private func showRegisterVC() {
		presenter.showRegisterVC()
	}
}

	//MARK: - Setting View

private extension MainViewController {
	func setupView() {
		view.backgroundColor = #colorLiteral(red: 0.2346754968, green: 0.2547710538, blue: 0.2673111558, alpha: 1)
		addSubViews()
		
		setupNavigationController()
		addActions()
		
		setupStackView()
		
		setupLayout()
	}
}

	//MARK: - Setting

private extension MainViewController {
	func addSubViews() {
		[stackView, womanButton, manButton].forEach { subView in
			view.addSubview(subView)
		}
	}
	
	func setupNavigationController() {
		title = "Выбери категорию"
		
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		navigationController?.navigationBar.standardAppearance = navBarAppearance
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "person.circle"),
			style: .plain,
			target: self,
			action: #selector(showRegisterVC)
		)
		
		navigationController?.navigationBar.tintColor = .white
	}
	
	func addActions() {
		womanButton.addTarget(self,
							  action: #selector(showSelectionVCWomen),
							  for: .touchUpInside)
		
		manButton.addTarget(self,
							action: #selector(showSelectionVCMan),
							for: .touchUpInside)
	}
	
	func setupStackView() {
		stackView.axis = .vertical
		stackView.spacing = 50
		stackView.distribution = .fillEqually
		
		stackView.addArrangedSubview(manButton)
		stackView.addArrangedSubview(womanButton)
	}
}

	//MARK: - Layout

extension MainViewController {
	func setupLayout() {
		[stackView, womanButton, manButton].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
			
			manButton.heightAnchor.constraint(equalTo: manButton.widthAnchor, multiplier: 0.66),
			
			womanButton.heightAnchor.constraint(equalTo: womanButton.widthAnchor, multiplier: 0.66)
			
		])
	}
}

	//MARK: - MainViewProtocol

extension MainViewController: IMainView {
	
}

