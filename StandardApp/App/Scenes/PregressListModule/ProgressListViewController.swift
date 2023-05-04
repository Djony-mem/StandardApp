	//
	//  ProgressListViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 09.04.2023.
	//

import UIKit

protocol IProgressList: AnyObject {
	func setuptitle(_ title: String)
	func render(viewData: [ViewModelProgress])
}

class ProgressListViewController: UITableViewController {
	var presenter: IProgressPresenter!
	
	private var progressViewModels = [ViewModelProgress]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}
	//MARK: - Setting View
private extension ProgressListViewController {
	func setupView() {
		tableView.backgroundColor = ColorSpace.BgColor.mainVC
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		presenter.fetchData()
		presenter.sendTitle()
	}
}

	//MARK: - Setting
private extension ProgressListViewController {
}

	// MARK: - TableViewDataSource
extension ProgressListViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		progressViewModels.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		let viewModel = progressViewModels[indexPath.row]
		
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		let formattedDate = formatter.string(from: viewModel.date)
		
		var content = cell.defaultContentConfiguration()
		content.image = UIImage(named: viewModel.imageRank)
		content.text = "\(viewModel.distance)    \(viewModel.userRank)"
		content.secondaryText = "\(viewModel.userTime)        \(formattedDate)"
		
		cell.contentConfiguration = content
		cell.backgroundColor = ColorSpace.BgColor.mainVC
		return cell
	}
}

	// MARK: - TableViewDelegate
extension ProgressListViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		presenter.didSelecterRow(indexPath: indexPath)
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			progressViewModels.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			presenter.deleteTiemResulet(index: indexPath.row)
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		80
	}
}

extension ProgressListViewController: IProgressList {
	func setuptitle(_ title: String) {
		navigationItem.title = title
	}
	
	func render(viewData: [ViewModelProgress]) {
		progressViewModels = viewData
	}
}
