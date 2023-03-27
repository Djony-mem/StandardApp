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
	
	private let bgImageView = UIImageView()
	
	private let placeSwitch = UISwitch()
	private let placeLabel = UILabel()

	private let pickerDistans = UIPickerView()
	private let pickerTime = UIPickerView()

	private let timingButton = ChosenButton(
		bgColor: UIColor(red: 185/255, green: 122/255, blue: 25/255, alpha: 1),
		disabledColor: UIColor(red: 81/255, green: 87/255, blue: 91/255, alpha: 1))
	private let circleLengthButton = ChosenButton(
		bgColor: UIColor(red: 185/255, green: 122/255, blue: 25/255, alpha: 1),
		disabledColor: UIColor(red: 81/255, green: 87/255, blue: 91/255, alpha: 1))
	
	private let resultButton = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	//MARK: - Actions
	@objc
	private func switchAction() {
		let text = placeSwitch.isOn ? "Шоссе" : "Стадион"
		placeLabel.text = text
	}
}

//MARK: - Settings View
private extension SelectionViewController{
	func setupView() {
		presenter.presentDistance()
		view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
		addSubviews()
		
		addActions()
		
		setupBgImageView()
		setupPlaceLabel()
		setupPickerDistance()
		setupPickerTime()
		setupTimingButton()
		setupCircleLengthButton()
		setupResultButton()
		
		setupLayout()
	}
}

//MARK: - Setting
private extension SelectionViewController{
	func addSubviews() {
		[bgImageView, placeSwitch, placeLabel, pickerDistans, timingButton,
		 circleLengthButton, pickerTime, resultButton].forEach { subView in
			view.addSubview(subView)
		}
	}
	
	func addActions() {
		placeSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
	}
	
	func setupBgImageView() {
		bgImageView.image = UIImage(named: "bgSelectV3")
	}
	
	func setupPlaceLabel() {
		let text = placeSwitch.isOn ? "Шоссе" : "Стадион"
		placeLabel.text = text
		placeLabel.font = .boldSystemFont(ofSize: 25)
		placeLabel.textColor = UIColor(red: 185/255, green: 122/255, blue: 25/255, alpha: 1)
	}
	
	func setupPickerDistance() {
		pickerDistans.delegate = self
		pickerDistans.dataSource = self
	}
	
	func setupPickerTime() {
		pickerTime.delegate = self
		pickerTime.dataSource = self
	}
	
	func setupTimingButton() {
		timingButton.menu = UIMenu(children: [
			UIAction(title: "Ручной", state: .on, handler: {_ in }),
			UIAction(title: "Авто", handler: {_ in })
		])
	}
	
	func setupCircleLengthButton() {
		circleLengthButton.menu = UIMenu(children: [
			UIAction(title: "400 метров", state: .on, handler: {_ in }),
			UIAction(title: "200 метров", handler: {_ in })
		])
	}
	
	func setupResultButton() {
		resultButton.setTitle("Проверить результат", for: .normal)
		resultButton.setTitleColor(
			UIColor(red: 127/255, green: 193/255, blue: 154/255, alpha: 1), for: .normal
		)
		resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
		resultButton.layer.cornerRadius = 10
		resultButton.backgroundColor = #colorLiteral(red: 0.03404390812, green: 0.2152546346, blue: 0.0269466769, alpha: 1)
	}
}

//MARK: - Layout
private extension SelectionViewController{
	func setupLayout() {
		[bgImageView, placeSwitch, placeLabel, pickerDistans, timingButton,
		 circleLengthButton, pickerTime, resultButton].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			
			bgImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
			
			placeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
			placeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
			
			placeSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
			placeSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

			pickerDistans.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 30),
			pickerDistans.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerDistans.heightAnchor.constraint(equalToConstant: 100),
			pickerDistans.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1.1),
			
			timingButton.topAnchor.constraint(equalTo: pickerDistans.bottomAnchor, constant: 30),
			timingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			timingButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			circleLengthButton.topAnchor.constraint(equalTo: timingButton.bottomAnchor, constant: 30),
			circleLengthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			circleLengthButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),

			pickerTime.topAnchor.constraint(equalTo: circleLengthButton.bottomAnchor, constant: 30),
			pickerTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerTime.heightAnchor.constraint(equalToConstant: 100),
			pickerTime.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1.1),
			
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
