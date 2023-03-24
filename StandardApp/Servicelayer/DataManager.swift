//
//  DataManager.swift
//  StandardApp
//
//  Created by brubru on 29.11.2022.
//

import Foundation

protocol IDataManager {
	func getStandard(resorce: String, type: String, completion: (Standard) -> Void)
}

class DataManager: IDataManager {
	
	func getStandard(resorce: String, type: String, completion: (Standard) -> Void) {
		guard let path = Bundle.main.path(forResource: resorce,
										  ofType: type) else { return }
		let url = URL(fileURLWithPath: path)
		
		do {
			let data = try Data(contentsOf: url)
			let standard = try JSONDecoder().decode(Standard.self, from: data)
			completion(standard)
		} catch {
			print("Error: \(error)")
		}
	}
}
