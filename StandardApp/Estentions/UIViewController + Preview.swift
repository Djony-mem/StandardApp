//
//  UIViewController + Preview.swift
//  StandardApp
//
//  Created by brubru on 27.03.2023.
//
import UIKit
import SwiftUI

extension UIViewController {
	struct Preview: UIViewControllerRepresentable {
		let viewController: UIViewController
		func makeUIViewController(context: Context) -> UIViewController {
			viewController
		}
		
		func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
	}
	
	func preview() -> some View {
		Preview(viewController: self).edgesIgnoringSafeArea(.all)
	}
}

