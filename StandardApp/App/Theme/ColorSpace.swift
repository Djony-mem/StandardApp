//
//  ColorSpace.swift
//  StandardApp
//
//  Created by brubru on 28.03.2023.
//

import UIKit


enum ColorSpace {
	enum BgColor {
		static let mainVC = UIColor(
			red: 23/255,
			green: 23/255,
			blue: 23/255,
			alpha: 1
		)
		
		static let navigation = UIColor(
			red: 12/255,
			green: 20/255,
			blue: 27/255,
			alpha: 1
		)
	}
	
	enum ActiveElement {
		static let enebled = UIColor(
			red: 185/255,
			green: 122/255,
			blue: 25/255,
			alpha: 1
		)
		
		static let notEnebled = UIColor(
			red: 81/255,
			green: 87/255,
			blue: 91/255,
			alpha: 1
		)
	}
	
	enum ResultButton {
		static let titleColor = UIColor(
			red: 127/255,
			green: 193/255,
			blue: 154/255,
			alpha: 1
		)
		
		static let bgEnebled =  UIColor(
			red: 9/255,
			green: 55/255,
			blue: 7/255,
			alpha: 1
		)
	}
	
	enum Text {
		static let main =  UIColor(
			red: 173/255,
			green: 181/255,
			blue: 197/255,
			alpha: 1
		)
		
		static let rank = UIColor(
			red: 245/255,
			green: 180/255,
			blue: 51/255,
			alpha: 1
		)
		
		static let time = UIColor(
			red: 250/255,
			green: 128/255,
			blue: 92/255,
			alpha: 1
		)
	}
}
