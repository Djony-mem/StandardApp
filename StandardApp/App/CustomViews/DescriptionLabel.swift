//
//  DescriptionLabel.swift
//  StandardApp
//
//  Created by brubru on 27.03.2023.
//

import UIKit

class DescriptionLabel: UILabel {
	init(title: String) {
		super.init(frame: .zero)
		setupDescriptionLabel(title: title)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupDescriptionLabel(title: String) {
		text = title
		font = .systemFont(ofSize: 15)
	}
	
}
