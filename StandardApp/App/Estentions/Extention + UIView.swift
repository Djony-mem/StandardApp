//
//  Extention + UIView.swift
//  StandardApp
//
//  Created by brubru on 24.03.2023.
//

import UIKit

extension UIView {
	func addGradient() {
		let primaryColor = UIColor(red: 210, green: 109, blue: 128)
		
		let secondaryColor = UIColor(red: 107, green: 148, blue: 230)

		backgroundColor = .clear
		let gradient = CAGradientLayer()
		gradient.frame = bounds
		gradient.colors = [primaryColor.cgColor, secondaryColor.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 0, y: 1)
		layer.insertSublayer(gradient, at: 0)
	}
}
