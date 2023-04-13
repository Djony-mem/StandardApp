//
//  ResultViewController.swift
//  StandardApp
//
//  Created by brubru on 09.04.2023.
//

import UIKit

protocol IResultViewController {
	
}

class ResultViewController: UIViewController {
	
	private let imageViewReward = UIImageView()
	private let rankLabel = DescriptionLabel(title: "Ты можешь лучше")
	

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

//MARK: - Setting View
extension ResultViewController {
	func setupView() {
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
			imageViewReward.heightAnchor.constraint(equalTo: imageViewReward.widthAnchor, multiplier: 1)
		])
	}
}

//MARK: - IResultViewController
extension ResultViewController: IResultViewController {
	
}
