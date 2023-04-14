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
	
	private let rewardImageView = UIImageView()
	
	private let descriptionRankLabel = DescriptionLabel(title: "Разряд:")
	private let descriptionAllRankLabel = DescriptionLabel(title: "Другие разряды:")
	private let descriptionRecordLabel = DescriptionLabel(title: "Рекордсмен России:")
	
	private let rankLabel = UILabel()
	private let userTimeLabel = UILabel()
	
	private let allRankLabel = UILabel()
	
	private let nameRecordLabel = UILabel()
	private let timeRecordLabel = UILabel()
	private let dateRecordLabel = UILabel()
	
	private let recordStackView = UIStackView()
	
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
		
		setupAllRankLabel()
		setupAllRankView()
		
		setupNameRecordLabel()
		setupTimeRecordLabel()
		setupDateRecordLabel()
		
		setupStackRecordHolder()
		
		setupLayout()
	}
}

//MARK: - Setting
private extension ResultViewController {
	func addSubviews() {
		[rewardImageView, descriptionRankLabel,
		 rankLabel, userTimeLabel, descriptionAllRankLabel,
		 allRankView, descriptionRecordLabel,
		 recordStackView, allRankLabel].forEach { subview in
			view.addSubview(subview)
		}
	}
	
	func setupRankLabel() {
		rankLabel.textColor = ColorSpace.Text.rank
		rankLabel.textAlignment = .center
		rankLabel.font = .boldSystemFont(ofSize: 20)
		rankLabel.numberOfLines = 0
	}
	
	func setupUserTime() {
		userTimeLabel.text = "00:00:00,00"
		userTimeLabel.textColor = ColorSpace.Text.time
		userTimeLabel.textAlignment = .center
		userTimeLabel.font = .boldSystemFont(ofSize: 20)
	}
	
	func setupAllRankLabel() {
		allRankLabel.text = """
	   let msmk:  "00:00:00,00"
	   let ms:  "00:00:00,00"
	   let kms:  "00:00:00,00"
	   let firstRank: "00:00:00,00"
	   let secondRank: "00:00:00,00"
	   let thirdRank: "00:00:00,00"
	   let firstJunior: "00:00:00,00"
	   let secondJunior: "00:00:00,00"
	   let thirdJunior: "00:00:00,00"
	   """
		allRankLabel.numberOfLines = 0
	}
	
	func setupAllRankView() {
		allRankView.backgroundColor = .systemGray
		allRankView.layer.cornerRadius = 15
		
		allRankView.layer.shadowColor = UIColor.black.cgColor
		allRankView.layer.shadowRadius = 20
		allRankView.layer.shadowOpacity = 1
		allRankView.layer.shadowOffset = CGSize(width: 15, height: 15)
	}
	
	func setupNameRecordLabel() {
		nameRecordLabel.text = "Герой"
		nameRecordLabel.textColor = ColorSpace.Text.rank
		nameRecordLabel.font = .boldSystemFont(ofSize: 20)
	}
	
	func setupTimeRecordLabel() {
		timeRecordLabel.text = "00:00:00,00"
		timeRecordLabel.textColor = ColorSpace.Text.time
		timeRecordLabel.font = .boldSystemFont(ofSize: 18)
	}
	
	func setupDateRecordLabel() {
		dateRecordLabel.text = "02.06.2007"
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
		 allRankView, descriptionRecordLabel, recordStackView, nameRecordLabel,
		 timeRecordLabel, dateRecordLabel, allRankLabel].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			rewardImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			rewardImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			rewardImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
			rewardImageView.widthAnchor.constraint(equalTo: rewardImageView.heightAnchor, multiplier: 1),
			
			descriptionRankLabel.topAnchor.constraint(equalTo: rewardImageView.bottomAnchor, constant: 10),
			descriptionRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			rankLabel.topAnchor.constraint(equalTo: descriptionRankLabel.bottomAnchor, constant: 10),
			rankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			rankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			userTimeLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 10),
			userTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			userTimeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			
			descriptionAllRankLabel.topAnchor.constraint(equalTo: userTimeLabel.bottomAnchor, constant: 20),
			descriptionAllRankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionAllRankLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			allRankView.topAnchor.constraint(equalTo: descriptionAllRankLabel.bottomAnchor, constant: 10),
			allRankView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			allRankView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
			allRankView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			allRankLabel.topAnchor.constraint(equalTo: allRankView.topAnchor, constant: 0),
			allRankLabel.leftAnchor.constraint(equalTo: allRankView.leftAnchor, constant: 5),
			allRankLabel.rightAnchor.constraint(equalTo: allRankView.rightAnchor, constant: 0),
			allRankLabel.bottomAnchor.constraint(equalTo: allRankView.bottomAnchor, constant: 0),
			
			descriptionRecordLabel.topAnchor.constraint(equalTo: allRankView.bottomAnchor, constant: 25),
			descriptionRecordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			descriptionRecordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			
			recordStackView.topAnchor.constraint(equalTo: descriptionRecordLabel.bottomAnchor, constant: 10),
			recordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			recordStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
		])
	}
}

//MARK: - IResultViewController
extension ResultViewController: IResultView {
	func render(viewModel: ViewModelResult) {
		rewardImageView.image = UIImage(named: viewModel.image)
		rankLabel.text = viewModel.rank
	}
}
