//
//  GenderButton.swift
//  StandardApp
//
//  Created by brubru on 15.12.2022.
//

import UIKit

class GenderButton: UIButton {
    
    init(normalStateImage: String, highlightStateImage: String) {
        super.init(frame: .zero)
        setupGenderButton(normalStateImage: normalStateImage,
                          highlightStateImage: highlightStateImage)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGenderButton(normalStateImage: String, highlightStateImage: String) {
        setBackgroundImage(UIImage(named: normalStateImage), for: .normal)
        setBackgroundImage(UIImage(named: highlightStateImage), for: .highlighted)
		layer.borderColor = ColorSpace.ActiveElement.enebled.cgColor
		layer.borderWidth = 2
		layer.cornerRadius = 30
        sizeToFit()
    }
}
