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
        sizeToFit()
        layer.cornerRadius = 15
        clipsToBounds = true
        
        layer.shadowColor = UIColor.systemBlue.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
        createGradient()
    }
    
    private func createGradient() {
        
        backgroundColor = .clear
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0.1)
        layer.insertSublayer(gradient, at: 0)
    }
}
