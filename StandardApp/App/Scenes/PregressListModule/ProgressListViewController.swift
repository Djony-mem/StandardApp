	//
	//  ProgressListViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 09.04.2023.
	//

import UIKit

protocol IProgressList: AnyObject {
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
		tableView.backgroundColor = .cyan
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		presenter.fetchData()
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
		cell.textLabel?.text = viewModel.userTime
		
		return cell
	}
}

	// MARK: - TableViewDelegate
extension ProgressListViewController {
	
}

extension ProgressListViewController: IProgressList {
	func render(viewData: [ViewModelProgress]) {
		progressViewModels = viewData
	}
}
