//
//  MainListViewCell.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import UIKit


class MainListViewCell: UICollectionViewCell {
	
	static let identifier = "Cell"
	
    private let genderImage = UIImageView()
	private let genderLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCollectionView()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		genderImage.frame = CGRect(
			x: 5,
			y: 5,
			width: contentView.frame.width * 0.4,
			height: contentView.frame.height * 0.9)
		
		genderLabel.frame = CGRect(
			x: genderImage.frame.width ,
			y: 5,
			width: contentView.frame.width * 0.6,
			height: contentView.frame.height * 0.9
		)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func configur(viewModel: ViewModel) {
		switch viewModel.gender {
		case .male:
			genderImage.image = UIImage(named: "man")
		case .fimale:
			genderImage.image = UIImage(named: "women")
		}
		
		genderLabel.text = viewModel.nikName
	}
}

// MARK: - Setting ContentView
private extension MainListViewCell {
	func setupCollectionView() {
		contentView.layer.cornerRadius = 20
//		contentView.backgroundColor = ColorSpace.BgColor.navigation
		contentView.layer.borderColor = ColorSpace.ActiveElement.enebled.cgColor
		
		contentView.layer.borderWidth = 2
		
		addSubviews()
		
		setupGenderImage()
		setupGenderLabel()
	}
}

// MARK: - Setting
private extension MainListViewCell {
	func addSubviews() {
		contentView.addSubview(genderImage)
		contentView.addSubview(genderLabel)
	}
	
	func setupGenderImage() {
		genderImage.image = UIImage(named: "man")
	}
	
	func setupGenderLabel() {
		genderLabel.font = UIFont.systemFont(ofSize: 25)
		genderLabel.textColor = ColorSpace.ActiveElement.enebled
		genderLabel.numberOfLines = 0
		genderLabel.text = "Евгения Бруйкоша"
	}
}
