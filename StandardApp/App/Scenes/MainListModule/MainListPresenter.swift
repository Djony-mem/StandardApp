//
//  MainListPresenter.swift
//  StandardApp
//
//  Created by brubru on 06.04.2023.
//

import Foundation

struct ViewModel {
	let nikName: String
	let gender: Gender
}

protocol IMainListPresenter: AnyObject {
	var standard: Standard! { get }
	
	func viewDidLoad() 
	func addNewAthlete(viewModel: ViewModel)
	func deleteAthlete(index: Int)
	func render(index: IndexPath)
	func showNewAthleteVC()
}

final class MainListPresenter {
	var athletes = [Athlete]()
	var standard: Standard!
	
	private weak var view: IMainListView?
	private let dataManager: IDataManager!
	private let router: IMainListRouter?
	private let storageManager: IStorageManager
	
	
	required init(view: IMainListView,
				  dataManager: IDataManager,
				  router: IMainListRouter,
				  storage: IStorageManager) {
		self.view = view
		self.dataManager = dataManager
		self.router = router
		self.storageManager = storage
		getStandard()
	}
}

extension MainListPresenter: IMainListPresenter {
	func viewDidLoad() {
		storageManager.getAthletes { result in
			switch result {
			case .success(let athletes):
				self.athletes = athletes
				var viewModels = [ViewModel]()
				
				athletes.forEach { athlete in
					let viewModel = ViewModel(
						nikName: athlete.nikName ?? "",
						gender: athlete.gender == Gender.male.rawValue
						? Gender.male
						: Gender.fimale
					)
					viewModels.append(viewModel)
				}
				
				view?.render(viewModels: viewModels)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	func addNewAthlete(viewModel: ViewModel) {
		storageManager.createAthlet(
			name: viewModel.nikName,
			gender: viewModel.gender.rawValue) { athlete in
				athletes.append(athlete)
			}
	}
	
	func deleteAthlete(index: Int) {
		athletes.remove(at: index)
	}
	
	func render(index: IndexPath) {
		let athlete = athletes[index.row]
		switch athlete.gender {
		case Gender.male.rawValue:
			router?.route(.selection(distance: standard.man, athlete: athlete))
		default:
			router?.route(.selection(distance: standard.woman,  athlete: athlete))
		}
	}
	
	func showNewAthleteVC() {
		router?.route(.addNewAthlete)
	}
	
	private func getStandard() {
		dataManager.getStandard(resorce: "data", type: "json") { standard in
			self.standard = standard
		}
	}
}
