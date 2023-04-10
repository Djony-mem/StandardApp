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
	
	private let imageReward = UIImageView()
	private let rankLabel = DescriptionLabel(title: "1 Разряд")

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
		
	}
}

//MARK: - Layout
extension ResultViewController {
	func setupLayout() {
		
	}
}

//MARK: - IResultViewController
extension ResultViewController: IResultViewController {
	
}
