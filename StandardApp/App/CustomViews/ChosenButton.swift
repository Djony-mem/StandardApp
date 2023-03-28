//
//  chosenButton.swift
//  StandardApp
//
//  Created by brubru on 24.03.2023.
//

import UIKit

final class ChosenButton: UIButton {
	
	init(borderColor: UIColor, disabledColor: UIColor) {
		super.init(frame: .zero)
		setupChosenButton(borderColor: borderColor, disabledColor: disabledColor)
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupChosenButton(borderColor: UIColor, disabledColor: UIColor) {
		setTitleColor(borderColor, for: .normal)
		setTitleColor(disabledColor, for: .disabled)
		layer.cornerRadius = 10
		layer.borderWidth = 2
		layer.borderColor = borderColor.cgColor
		
		showsMenuAsPrimaryAction = true
		changesSelectionAsPrimaryAction = true
		
		titleLabel?.font = .boldSystemFont(ofSize: 20)
	}
}

//MARK: - Layout
private extension ChosenButton {
	func setupLayout() {
		heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
}
