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

final class ResultViewController: UIViewController {
	
	var viewModelResult: ViewModelResult!
	var presenter: IResultPresenter!
	
	private let rewardImageView = UIImageView()
	
	private let descriptionRankLabel = DescriptionLabel(title: "Разряд:")
	private let descriptionAllRankLabel = DescriptionLabel(title: "Другие разряды:")
	private let descriptionRecordLabel = DescriptionLabel(title: "Установленный рекорд России:")
	
	private let rankLabel = UILabel()
	private let userTimeLabel = UILabel()
	
	private let allRankLabel = UILabel()
	
	private let nameRecordLabel = UILabel()
	private let timeRecordLabel = UILabel()
	private let dateRecordLabel = UILabel()
	
	private let recordStackView = UIStackView()
	
	private let saveButton = ResultButton(title: "Сохранить")

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
	
	@objc
	private func saveResultInfo() {
		presenter.dismissActiion()
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
		
		setupAllRankLabel()
		
		setupNameRecordLabel()
		setupTimeRecordLabel()
		setupDateRecordLabel()
		
		setupStackRecordHolder()
		
		addActions()
		
		setupLayout()
	}
}

//MARK: - Setting
private extension ResultViewController {
	func addSubviews() {
		[rewardImageView, descriptionRankLabel,
		 rankLabel, userTimeLabel, descriptionAllRankLabel, descriptionRecordLabel,
		 recordStackView, allRankLabel, saveButton].forEach { subview in
			view.addSubview(subview)
		}
	}
	
	func addActions() {
		saveButton.addTarget(
			self,
			action: #selector(saveResultInfo),
			for: .touchUpInside
		)
	}
	
	func setupRankLabel() {
		rankLabel.textColor = ColorSpace.Text.rank
		rankLabel.textAlignment = .center
		rankLabel.font = .boldSystemFont(ofSize: 20)
		rankLabel.numberOfLines = 0
	}
	
	func setupUserTime() {
		userTimeLabel.textColor = ColorSpace.Text.time
		userTimeLabel.textAlignment = .center
		userTimeLabel.font = .boldSystemFont(ofSize: 20)
	}
	
	func setupAllRankLabel() {
		allRankLabel.textColor = ColorSpace.Text.time
		allRankLabel.numberOfLines = 0
	}
	
	func setupNameRecordLabel() {
		nameRecordLabel.textColor = ColorSpace.Text.rank
		nameRecordLabel.font = .boldSystemFont(ofSize: 20)
	}
	
	func setupTimeRecordLabel() {
		timeRecordLabel.textColor = ColorSpace.Text.time
		timeRecordLabel.font = .boldSystemFont(ofSize: 18)
	}
	
	func setupDateRecordLabel() {
		dateRecordLabel.textColor = .white
		dateRecordLabel.font = .boldSystemFont(ofSize: 15)
	}
	
	func setupStackRecordHolder() {
		recordStackView.axis = .vertical
		recordStackView.distribution = .fillEqually
		
		recordStackView.addArrangedSubview(nameRecordLabel)
		recordStackView.addArrangedSubview(timeRecordLabel)
		recordStackView.addArrangedSubview(dateRecordLabel)
	}
}

//MARK: - Layout
private extension ResultViewController {
	func setupLayout() {
		[rewardImageView, descriptionRankLabel,
		 rankLabel, userTimeLabel, descriptionAllRankLabel,
		 descriptionRecordLabel, recordStackView, nameRecordLabel,
		 timeRecordLabel, dateRecordLabel, allRankLabel, saveButton].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			rewardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			rewardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			rewardImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
			rewardImageView.widthAnchor.constraint(equalTo: rewardImageView.heightAnchor, multiplier: 1),
			
			descriptionRankLabel.topAnchor.constraint(equalTo: rewardImageView.bottomAnchor, constant: 10),
			descriptionRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			rankLabel.topAnchor.constraint(equalTo: descriptionRankLabel.bottomAnchor, constant: 8),
			rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			rankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			userTimeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 10),
			userTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			userTimeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			descriptionAllRankLabel.topAnchor.constraint(equalTo: userTimeLabel.bottomAnchor, constant: 10),
			descriptionAllRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionAllRankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			allRankLabel.topAnchor.constraint(equalTo: descriptionAllRankLabel.bottomAnchor, constant: 10),
			allRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			allRankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			descriptionRecordLabel.topAnchor.constraint(equalTo: allRankLabel.bottomAnchor, constant: 10),
			descriptionRecordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionRecordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			recordStackView.topAnchor.constraint(equalTo: descriptionRecordLabel.bottomAnchor, constant: 10),
			recordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			recordStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			saveButton.topAnchor.constraint(equalTo: recordStackView.bottomAnchor, constant: 20),
			saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			saveButton.widthAnchor.constraint(equalToConstant: 200)
		])
	}
}

//MARK: - IResultViewController
extension ResultViewController: IResultView {
	func render(viewModel: ViewModelResult) {
		rewardImageView.image = UIImage(named: viewModel.imageRank)
		descriptionRankLabel.text = "Дистанция \(viewModel.distance)"
		rankLabel.text = viewModel.userRank
		userTimeLabel.text = viewModel.userTime
		allRankLabel.text = viewModel.allRank
		
		nameRecordLabel.text = viewModel.record.fullName
		timeRecordLabel.text = viewModel.record.time
		dateRecordLabel.text = viewModel.record.recordDate
	}
}
