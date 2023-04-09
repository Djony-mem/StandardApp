//
//  ResultButton.swift
//  StandardApp
//
//  Created by brubru on 09.04.2023.
//

import UIKit


final class ResultButton: UIButton {
	
	init(title: String) {
		super.init(frame: .zero)
		setupResultButton(title: title)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupResultButton(title: String) {
		setTitle(title, for: .normal)
		setTitleColor(
			ColorSpace.ResultButton.titleColor, for: .normal
		)
		setTitleColor(.gray, for: .highlighted)
		titleLabel?.font = .boldSystemFont(ofSize: 20)
		layer.cornerRadius = 10
		backgroundColor = ColorSpace.ResultButton.bgEnebled
	}
}
