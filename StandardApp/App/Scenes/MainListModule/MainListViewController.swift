	//
	//  MainListViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 06.04.2023.
	//

import UIKit
import SwiftUI


protocol IMainListView: AnyObject {
	func render(viewModels: [ViewModel])
	func replace(viewModel: ViewModel)
}

// MARK: - MainListViewController
final class MainListViewController: UICollectionViewController {

	private let addButton = CustomBarButton(image: "plus.app")
	private var viewModels = [ViewModel]()
	
	var presenter: IMainListPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupSubView()
		
		presenter.viewDidLoad()
	}
	
	//MARK: - Actions
	@objc
	private func addNewAthlete() {
		presenter.showNewAthleteVC()
	}
}

//MARK: - Setting View
private extension MainListViewController {
	func setupView() {
		collectionView.backgroundColor = ColorSpace.BgColor.mainVC
		collectionView.register(MainListViewCell.self, forCellWithReuseIdentifier: MainListViewCell.identifier)
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	func setupSubView() {
		addActions()
		
		setupNavigationController()
	}
}

//MARK: - Setting
private extension MainListViewController {
	func addActions() {
		addButton.addTarget(self, action: #selector(addNewAthlete), for: .touchUpInside)
	}
	
	func setupNavigationController() {
		title = "Список Атлетов"

		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 10)]

		navigationController?.navigationBar.standardAppearance = navBarAppearance
		
		navBarAppearance.backgroundColor = ColorSpace.ResultButton.bgEnebled
		navBarAppearance.titleTextAttributes = [.foregroundColor: ColorSpace.ResultButton.titleColor]
		
		
		navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
		
		navigationController?.navigationBar.isTranslucent = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
		
		navigationController?.navigationBar.tintColor = ColorSpace.ResultButton.titleColor
	}
}

// MARK: - UICollectionViewDataSource
extension MainListViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModels.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainListViewCell.identifier, for: indexPath) as? MainListViewCell else { return UICollectionViewCell()}
		let viewModel = viewModels[indexPath.row]

		cell.configur(viewModel: viewModel)
		return cell
	}
}

// MARK: - UICollectionViewDelegate
extension MainListViewController {
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.render(index: indexPath)
	}
	
	override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
		let deleteItem = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { (_) in
			self.presenter.deleteAthlete(index: indexPaths.first?.row ?? 0)
			self.viewModels.remove(at: indexPaths.first?.row ?? 0)
			collectionView.deleteItems(at: indexPaths)
		}
		let editItem = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { (_) in
			
		}
		
		return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
			UIMenu(title: "Options", children: [editItem, deleteItem])
		})
		
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainListViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: collectionView.frame.width * 0.86, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		20
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		CGSize(width: 0, height: 20)
	}
}

//MARK: - IMainListView
extension MainListViewController: IMainListView {
	func render(viewModels: [ViewModel]) {
		self.viewModels = viewModels
	}
	
	func replace(viewModel: ViewModel) {
		presenter.addNewAthlete(viewModel: viewModel)
		viewModels.append(viewModel)
		collectionView.reloadData()
	}
}

