	//
	//  ProgressListViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 09.04.2023.
	//

import UIKit

protocol IProgressList: AnyObject {
	
}

class ProgressListViewController: UITableViewController {
	var presenter: IProgressPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}
	//MARK: - Setting View
private extension ProgressListViewController {
	func setupView() {
		tableView.backgroundColor = .cyan
	}
}

	//MARK: - Setting
private extension ProgressListViewController {
	
}

	// MARK: - TableViewDataSource
extension ProgressListViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			// #warning Incomplete implementation, return the number of rows
		return 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		
			// Configure the cell...
		
		return cell
	}
}

	// MARK: - TableViewDelegate
extension ProgressListViewController {
	
}

extension ProgressListViewController: IProgressList {
	
}
