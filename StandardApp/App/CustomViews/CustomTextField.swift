//
//  CustomTextField.swift
//  StandardApp
//
//  Created by brubru on 08.04.2023.
//

import UIKit


class CustomTextField: UITextField {
	private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
	
	//MARK: - Initializers
	init(placeholder: String) {
		super.init(frame: .zero)
		setupTextField(placeholder: placeholder)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Override Methods
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		bounds.inset(by: padding)
	}

	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		bounds.inset(by: padding)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		bounds.inset(by: padding)
	}
	
	//MARK: - Private Methods
	private func setupTextField(placeholder: String) {
		textColor = .white
		tintColor = .white
		
		layer.cornerRadius = 10
		layer.borderColor = ColorSpace.ActiveElement.enebled.cgColor
		layer.borderWidth = 1.5
		
		attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorSpace.ActiveElement.notEnebled])
		font = .boldSystemFont(ofSize: 18)
		heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
}
