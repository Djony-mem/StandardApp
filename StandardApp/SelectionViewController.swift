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
	
	private let placeSwitch = UISwitch()
	private let pickerDistans = UIPickerView()
	private let pickerTime = UIPickerView()

	private let timingButton = ChosenButton(bgColor: UIColor(red: 185/255, green: 122/255, blue: 25/255, alpha: 1), disabledColor: UIColor(red: 81/255, green: 87/255, blue: 91/255, alpha: 1))
	private let circleLengthButton = ChosenButton(bgColor: UIColor(red: 185/255, green: 122/255, blue: 25/255, alpha: 1), disabledColor: UIColor(red: 81/255, green: 87/255, blue: 91/255, alpha: 1))
	
	private let resultButton = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupView() {
		presenter.presentDistance()
		view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
		addSubviews()
		
		addActions()
		setupPickerDistance()
		setupPickerTime()
		setupResultButton()
		
		setupLayout()
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func addSubviews() {
		[pickerDistans, timingButton, circleLengthButton, pickerTime, resultButton].forEach { subView in
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
	
	func setupResultButton() {
		resultButton.setTitle("Проверить результат", for: .normal)
		resultButton.setTitleColor(UIColor(red: 127/255, green: 193/255, blue: 154/255, alpha: 1), for: .normal)
		resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
		resultButton.layer.cornerRadius = 10
		resultButton.backgroundColor = #colorLiteral(red: 0.03404390812, green: 0.2152546346, blue: 0.0269466769, alpha: 1)
	}
}

//MARK: - SelectionViewProtocol
private extension SelectionViewController{
	func setupLayout() {
		[pickerDistans, timingButton,
		 circleLengthButton, pickerTime, resultButton].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			pickerDistans.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
			pickerDistans.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerDistans.heightAnchor.constraint(equalToConstant: 100),
			pickerDistans.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			timingButton.topAnchor.constraint(equalTo: pickerDistans.bottomAnchor, constant: 30),
			timingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			timingButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			circleLengthButton.topAnchor.constraint(equalTo: timingButton.bottomAnchor, constant: 30),
			circleLengthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			circleLengthButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),

			pickerTime.topAnchor.constraint(equalTo: circleLengthButton.bottomAnchor, constant: 30),
			pickerTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerTime.heightAnchor.constraint(equalToConstant: 100),
			pickerTime.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			resultButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
			resultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			resultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			resultButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
//MARK: - UIPickerViewDelegate
extension SelectionViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == pickerDistans {
			return "Дистанция"
		} else {
			return "00"
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		if pickerView == pickerDistans {
			return 150
		} else {
			return 50
		}
	}
//	
//	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//		let pickerLabel = UILabel()
//		pickerLabel.text = "00"
//		pickerLabel.font = .boldSystemFont(ofSize: 20)
//		return pickerLabel
//	}
}

//MARK: - UIPickerViewDataSource
extension SelectionViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		if pickerView == pickerDistans {
			return 1
		} else {
			return 4
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		(1...10).count
	}
}

	//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {

}
