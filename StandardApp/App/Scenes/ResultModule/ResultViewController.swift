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
	private let descriptionRankLabel = DescriptionLabel(title: "Разряд:")
	private let descriptionAllRankLabel = DescriptionLabel(title: "Другие разряды:")
	private let descriptionRecordLabel = DescriptionLabel(title: "Рекордсмен России:")
	
	private let rankLabel = UILabel()
	private let userTimeLabel = UILabel()
	
	private let allRankView = UIView()
	
	var presenter: IResultPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

//MARK: - Setting View
private extension ResultViewController {
	func setupView() {
		view.backgroundColor = ColorSpace.BgColor.mainVC
		presenter.render()
		addSubviews()
		
		setupRankLabel()
		setupUserTime()
		setupAllRankView()
		
		setupLayout()
	}
}

//MARK: - Setting
private extension ResultViewController {
	func addSubviews() {
		[imageViewReward, descriptionRankLabel,
		 rankLabel, userTimeLabel, descriptionAllRankLabel,
		 allRankView, descriptionRecordLabel].forEach { subview in
			view.addSubview(subview)
		}
	}
	
	func setupRankLabel() {
		rankLabel.textColor = ColorSpace.Text.rank
		rankLabel.textAlignment = .center
		rankLabel.font = .boldSystemFont(ofSize: 25)
		rankLabel.numberOfLines = 0
	}
	
	func setupUserTime() {
		userTimeLabel.text = "00:00:00,00"
		userTimeLabel.textColor = ColorSpace.Text.time
		userTimeLabel.textAlignment = .center
		userTimeLabel.font = .boldSystemFont(ofSize: 20)
	}
	
	func setupAllRankView() {
		allRankView.backgroundColor = .systemGray
		allRankView.layer.cornerRadius = 15
		
		allRankView.layer.shadowColor = UIColor.black.cgColor
		allRankView.layer.shadowRadius = 20
		allRankView.layer.shadowOpacity = 1
		allRankView.layer.shadowOffset = CGSize(width: 15, height: 15)
	}
}

//MARK: - Layout
private extension ResultViewController {
	func setupLayout() {
		[imageViewReward, descriptionRankLabel,
		 rankLabel, userTimeLabel, descriptionAllRankLabel,
		 allRankView, descriptionRecordLabel].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			imageViewReward.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			imageViewReward.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageViewReward.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
			imageViewReward.widthAnchor.constraint(equalTo: imageViewReward.heightAnchor, multiplier: 1),
			
			descriptionRankLabel.topAnchor.constraint(equalTo: imageViewReward.bottomAnchor, constant: 10),
			descriptionRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			rankLabel.topAnchor.constraint(equalTo: descriptionRankLabel.bottomAnchor, constant: 15),
			rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			rankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			userTimeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 10),
			userTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			userTimeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			descriptionAllRankLabel.topAnchor.constraint(equalTo: userTimeLabel.bottomAnchor, constant: 30),
			descriptionAllRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionAllRankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			allRankView.topAnchor.constraint(equalTo: descriptionAllRankLabel.bottomAnchor, constant: 10),
			allRankView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			allRankView.heightAnchor.constraint(equalToConstant: 150),
			allRankView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			descriptionRecordLabel.topAnchor.constraint(equalTo: allRankView.bottomAnchor, constant: 30),
			descriptionRecordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionRecordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
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
