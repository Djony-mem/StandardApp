	//
	//  SelectionPresenter.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import Foundation


protocol ISelectionPresenter: AnyObject {
	func presentDistance()
}

class SelectionPresenter: ISelectionPresenter {
	weak var view: ISelectionView!
	let standardManager: IStandardManager?
	
	required init(view: ISelectionView, standardManager: IStandardManager) {
		self.view = view
		self.standardManager = standardManager
	}
	
	func presentDistance() {
//		view.presentDist(distance!)
	}
}
