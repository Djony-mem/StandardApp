	//
	//  ViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import UIKit

protocol ISelectionView: AnyObject {
	
}

	//MARK: - SelectionViewController
class SelectionViewController: UIViewController {
	var presenter: ISelectionPresenter!
	
	private let pickerDistans = UIPickerView()
	private let pickerTime = UIPickerView()
	
	private let placeButton = ChosenButton(bgColor: .blue, disabledColor: .orange)
	private let timingButton = ChosenButton(bgColor: .blue, disabledColor: .orange)
	private let circleLengthButton = ChosenButton(bgColor: .blue, disabledColor: .orange)
	
	private let stackButton = UIStackView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupView() {
		presenter.presentDistance()
		view.backgroundColor = #colorLiteral(red: 0.1785757244, green: 0.1885581911, blue: 0.2097945511, alpha: 1)
		
		addSubviews()
		
		addActions()
		setupPickerDistance()
		setupPickerTime()
		
		setupLayout()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func addSubviews() {
		[pickerDistans, placeButton, timingButton, circleLengthButton, pickerTime].forEach { subView in
			view.addSubview(subView)
		}
	}
	
	func addActions() {
		
	}
	
	func setupPickerDistance() {
		pickerDistans.delegate = self
		pickerDistans.dataSource = self
	}
	
	func setupPickerTime() {
		pickerTime.delegate = self
		pickerTime.dataSource = self
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupLayout() {
		[pickerDistans, placeButton, timingButton,
		 circleLengthButton, stackButton, pickerTime].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			pickerDistans.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			pickerDistans.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerDistans.heightAnchor.constraint(equalToConstant: 100),
			
			placeButton.topAnchor.constraint(equalTo: pickerDistans.bottomAnchor, constant: 30),
			placeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			timingButton.topAnchor.constraint(equalTo: placeButton.bottomAnchor, constant: 30),
			timingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			circleLengthButton.topAnchor.constraint(equalTo: timingButton.bottomAnchor, constant: 30),
			circleLengthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			pickerTime.topAnchor.constraint(equalTo: circleLengthButton.bottomAnchor, constant: 30),
			pickerTime.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}
//MARK: - UIPickerViewDelegate
extension SelectionViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		"100 метров"
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
	}
}

//MARK: - UIPickerViewDataSource
extension SelectionViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		(1...10).count
	}
}

	//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {

}
