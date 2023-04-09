//
//  CustomBarButton.swift
//  StandardApp
//
//  Created by brubru on 07.04.2023.
//

import UIKit

final class CustomBarButton: UIButton {
	
	init(image: String) {
		super.init(frame: .zero)
		setupCustomBarButton(image: image)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCustomBarButton(image: String) {
		let image = UIImage(systemName: image)
		setImage(image, for: .normal)
		
		frame = CGRect(x: 0, y: 0, width: 35, height: 55)
		
		imageView?.contentMode = .scaleAspectFit
		contentHorizontalAlignment = .fill
		contentVerticalAlignment = .fill
	}
}
