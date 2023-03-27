//
//  chosenButton.swift
//  StandardApp
//
//  Created by brubru on 24.03.2023.
//

import UIKit

final class ChosenButton: UIButton {
	
	init(bgColor: UIColor, disabledColor: UIColor) {
		super.init(frame: .zero)
		setupChosenButton(bgColor: bgColor, disabledColor: disabledColor)
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupChosenButton(bgColor: UIColor, disabledColor: UIColor) {
		setTitleColor(bgColor, for: .normal)
		setTitleColor(disabledColor, for: .disabled)
		layer.cornerRadius = 10
		layer.borderColor = bgColor.cgColor
		layer.borderWidth = 2
		
		showsMenuAsPrimaryAction = true
		changesSelectionAsPrimaryAction = true
		
		titleLabel?.font = .boldSystemFont(ofSize: 20)
	}
}

//MARK: - Layout
private extension ChosenButton {
	func setupLayout() {
		heightAnchor.constraint(equalToConstant: 40).isActive = true
		widthAnchor.constraint(equalToConstant: 200).isActive = true
	}
}
