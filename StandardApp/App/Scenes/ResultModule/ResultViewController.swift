//
//  ResultViewController.swift
//  StandardApp
//
//  Created by brubru on 09.04.2023.
//

import UIKit

protocol IResultView: AnyObject {
	func render(viewModel: ViewModelResult)
}

class ResultViewController: UIViewController {
	
	private let imageViewReward = UIImageView()
	private let rankLabel = DescriptionLabel(title: "Ты можешь лучше")
	var presenter: IResultPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

//MARK: - Setting View
extension ResultViewController {
	func setupView() {
		view.backgroundColor = ColorSpace.BgColor.mainVC
		presenter.render()
		addSubviews()
		
		setupLayout()
	}
}

//MARK: - Setting
extension ResultViewController {
	func addSubviews() {
		[imageViewReward, rankLabel].forEach { subview in
			view.addSubview(subview)
		}
	}
}

//MARK: - Layout
extension ResultViewController {
	func setupLayout() {
		[imageViewReward, rankLabel].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			imageViewReward.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
			imageViewReward.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageViewReward.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			imageViewReward.heightAnchor.constraint(equalTo: imageViewReward.widthAnchor, multiplier: 1),
			
			rankLabel.topAnchor.constraint(equalTo: imageViewReward.bottomAnchor, constant: 30),
			rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}

//MARK: - IResultViewController
extension ResultViewController: IResultView {
	func render(viewModel: ViewModelResult) {
		imageViewReward.image = UIImage(named: viewModel.image)
		rankLabel.text = viewModel.rank
	}
}
