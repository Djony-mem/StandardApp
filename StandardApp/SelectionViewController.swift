	//
	//  ViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 30.11.2022.
	//

import UIKit
import SwiftUI

protocol ISelectionView: AnyObject {
	func changeSwitchLabel(text: String)
	func changeColor(_ color: UIColor)
	func setuptitle(_ title: String)
	func setupBgGender(image: String)
	
	func saveTimeResult()
}

	//MARK: - SelectionViewController
class SelectionViewController: UIViewController {
	var presenter: ISelectionPresenter!
	
	private let bgImageView = UIImageView()
	
	private let progressButton = CustomBarButton(image: "figure.run")
	
	private let placeSwitch = UISwitch()
	private let placeLabel = UILabel()

	private let pickerDistans = UIPickerView()
	private let pickerTime = UIPickerView()
	
	private let timingLabel = DescriptionLabel(title: "Хронометраж")
	private let circleLengthLabel = DescriptionLabel(title: "Длинна круга")

	private let timingButton = ChosenButton(
		borderColor: ColorSpace.ActiveElement.enebled,
		disabledColor: ColorSpace.ActiveElement.notEnebled
	)
	private let circleLengthButton = ChosenButton(
		borderColor: ColorSpace.ActiveElement.enebled,
		disabledColor: ColorSpace.ActiveElement.notEnebled
	)
	
	private let resultButton = ResultButton(title: "Показать результат")
	
	private let distancesStadium = StadiumEnum.allCases
	private let distancesHighway = HighwayEnum.allCases
	
	private let times = Array(0...59)
	private let miliseconds = Array(0...99)
	
	private var hour = "00"
	private var minute = "00"
	private var second = "00"
	private var millisecond = "00"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	//MARK: - Actions
	@objc
	private func switchAction() {
		presenter.changedSwitchValue(placeSwitch.isOn)
		presenter.changeSwitchValueForColor(placeSwitch.isOn)
		presenter.changeSwithForPlace(placeSwitch.isOn)
		
		timingButton.isEnabled = !placeSwitch.isOn
		circleLengthButton.isEnabled = !placeSwitch.isOn
		
		pickerDistans.reloadAllComponents()
	}
	
	@objc
	private func showResultVC() {
		if let elements = timingButton.menu?.selectedElements.first {
			if elements.title == "Ручной" {
				presenter.timingMenuManualAction(cronometer: .manual)
			} else {
				presenter.timingMenuManualAction(cronometer: .auto)
			}
		}

		if let elements = circleLengthButton.menu?.selectedElements.first {
			if elements.title == "400 метров" {
				presenter.circleLengthMenuAction(circleEnum: .circleLength400)
			} else {
				presenter.circleLengthMenuAction(circleEnum: .circleLength200)
			}
		}
		
		let timeString = "\(hour):\(minute):\(second):\(millisecond)"
		let time = Time(stringLiteral: timeString)
		
		if timeString  == "00:00:00:00" {
			showAlert()
		}
		
		presenter.renderd(time: time)
	}
	
	@objc
	private func didTapBarButton() {
		presenter.didTapBarButton()
	}
	
	private func showAlert() {
		let alert = UIAlertController(
			title: "00:00:00:00",
			message: "Найди в себе силы сделать хотябы шаг",
			preferredStyle: .alert
		)
		let action = UIAlertAction(title: "ОК", style: .default)
		
		alert.addAction(action)
		
		present(alert, animated: true)
	}
}

//MARK: - Settings View
private extension SelectionViewController{
	func setupView() {
		
		view.backgroundColor = ColorSpace.BgColor.mainVC
		
		addSubviews()
		
		addActions()
		
		setupNavigationController()
		setupBgImageView()
		setupPlaceLabel()
		setupPickerDistance()
		setupPickerTime()
		
		setupLayout()
	}
}

//MARK: - Setting
private extension SelectionViewController{
	func addSubviews() {
		[bgImageView, placeSwitch,
		 placeLabel, pickerDistans,
		 timingLabel, timingButton,
		 circleLengthLabel, circleLengthButton,
		 pickerTime, resultButton].forEach { subView in
			view.addSubview(subView)
		}
	}
	
	func addActions() {
		placeSwitch.addTarget(
			self,
			action: #selector(switchAction),
			for: .valueChanged
		)
		
		resultButton.addTarget(
			self,
			action: #selector(showResultVC),
			for: .touchUpInside
		)
		
		progressButton.addTarget(
			self,
			action: #selector(didTapBarButton),
			for: .touchUpInside
		)
	}
	
	func setupNavigationController() {
		title = "Список Атлетов"

		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.backgroundColor = ColorSpace.ResultButton.bgEnebled
		navBarAppearance.titleTextAttributes = [.foregroundColor: ColorSpace.ResultButton.titleColor]
		navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
		
		navigationController?.navigationBar.isTranslucent = false
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: progressButton)
		navigationController?.navigationBar.tintColor = ColorSpace.ResultButton.titleColor
		
		navigationItem.backButtonTitle = "Back"
		
		presenter.sendTitle()
	}
	
	func setupBgImageView() {
		bgImageView.contentMode = .scaleAspectFit
		presenter.sendBGImage()
	}
	
	func setupPlaceLabel() {
		let text = placeSwitch.isOn ? "Шоссе" : "Стадион"
		placeLabel.text = text
		placeLabel.font = .boldSystemFont(ofSize: 25)
		placeLabel.textColor = ColorSpace.ActiveElement.enebled
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

//MARK: - Layout
private extension SelectionViewController{
	func setupLayout() {
		[bgImageView, placeSwitch,
		 placeLabel, pickerDistans,
		 timingLabel, timingButton,
		circleLengthLabel, circleLengthButton,
		 pickerTime, resultButton].forEach { subview in
			subview.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			
			bgImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
			bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
			
			placeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
			placeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
			
			placeSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
			placeSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),

			pickerDistans.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 20),
			pickerDistans.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerDistans.heightAnchor.constraint(equalToConstant: 100),
			pickerDistans.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1.1),
			
			timingLabel.topAnchor.constraint(equalTo: pickerDistans.bottomAnchor, constant: 20),
			timingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			timingLabel.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			timingButton.topAnchor.constraint(equalTo: timingLabel.bottomAnchor, constant: 8),
			timingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			timingButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			circleLengthLabel.topAnchor.constraint(equalTo: timingButton.bottomAnchor, constant: 30),
			circleLengthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			circleLengthLabel.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),
			
			circleLengthButton.topAnchor.constraint(equalTo: circleLengthLabel.bottomAnchor, constant: 8),
			circleLengthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			circleLengthButton.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1),

			pickerTime.topAnchor.constraint(equalTo: circleLengthButton.bottomAnchor, constant: 20),
			pickerTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			pickerTime.heightAnchor.constraint(equalToConstant: 80),
			pickerTime.widthAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1.1),
			
			resultButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
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
			if placeSwitch.isOn {
				presenter.changedPickerDistans(highway: distancesHighway[row])
				return distancesHighway[row].rawValue
			} else {
				setupCircleLengthButton(isEnebledLength: distancesStadium[row].isEnebledCircleLength)
				
				setupTimingButtonMenu(isOnlyManual: distancesStadium[row].isOnlyManual)
				setupCircleLengthButtonMenu(isOnly200: distancesStadium[row].isCircleLengthOnly200 )
				
				presenter.changedPickerDistans(stadium: distancesStadium[row])
				
				print(distancesStadium[row].rawValue)
				
				return distancesStadium[row].rawValue
			}
		} else {
			switch component {
			case 0:
				return stringConvert(number: times[row]) + " ч"
			case 1:
				return stringConvert(number: times[row]) + " м"
			case 2:
				return stringConvert(number: times[row]) + " с"
			default:
				return stringConvert(number: miliseconds[row])
			}
		}
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

		if pickerView == pickerDistans {
			if !placeSwitch.isOn {
				setupCircleLengthButton(isEnebledLength: distancesStadium[row].isEnebledCircleLength)
				
				setupTimingButtonMenu(isOnlyManual:  distancesStadium[row].isOnlyManual)
				
				setupCircleLengthButtonMenu(isOnly200: distancesStadium[row].isCircleLengthOnly200)
				presenter.changedPickerDistans(stadium: distancesStadium[row])
				
			} else {
				presenter.changedPickerDistans(highway: distancesHighway[row])
			}
		} else {
			
			switch component {
			case 0:
				hour = stringConvert(number: times[row])
			case 1:
				minute = stringConvert(number: times[row])
			case 2:
				second = stringConvert(number: times[row])
			default:
				millisecond = stringConvert(number: miliseconds[row])
			}
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		pickerView == pickerDistans ? 280 : 70
	}
}

//MARK: - UIPickerViewDataSource
extension SelectionViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return pickerView == pickerDistans ? 1 : 4
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == pickerDistans {
			return placeSwitch.isOn ? distancesHighway.count : distancesStadium.count
		} else {
			return component == 3 ? miliseconds.count : times.count
		}
	}
}

//MARK: - Private function
private extension SelectionViewController {
	func setupCircleLengthButton(isEnebledLength: Bool) {
		circleLengthButton.isEnabled = isEnebledLength
		
		circleLengthButton.layer.borderColor = isEnebledLength
		? ColorSpace.ActiveElement.enebled.cgColor
		: ColorSpace.ActiveElement.notEnebled.cgColor
	}

	func setupCircleLengthButtonMenu(isOnly200: Bool) {
		if isOnly200 {
			circleLengthButton.menu = UIMenu(children: [
				UIAction(title: "400 метров", state: .on, handler: { _ in
					self.presenter.circleLengthMenuAction(circleEnum: .circleLength400)
				}),
				UIAction(title: "200 метров", handler: {_ in
					self.presenter.circleLengthMenuAction(circleEnum: .circleLength200)
				})
			])
		} else {
			circleLengthButton.menu = UIMenu(children: [
				UIAction(title: "200 метров", handler: {_ in
					self.presenter.circleLengthMenuAction(circleEnum: .circleLength200)
				})
			])
		}
	}
	
	func setupTimingButtonMenu(isOnlyManual: Bool) {
		if isOnlyManual {
			timingButton.menu = UIMenu(children: [
				UIAction(title: "Ручной", state: .on, handler: {_ in
					self.presenter.timingMenuManualAction(cronometer: .manual)
				}),
				UIAction(title: "Авто", handler: {_ in
					self.presenter.timingMenuManualAction(cronometer: .auto)
				})
			])
		} else {
			timingButton.menu = UIMenu(children: [
				UIAction(title: "Ручной", state: .on, handler: {_ in
					self.presenter.timingMenuManualAction(cronometer: .manual)
				}),
			])
		}
	}
	
	func stringConvert(number: Int) -> String {
		String(format: "%02d", number)
	}
}


//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {
	func setupBgGender(image: String) {
		bgImageView.image = UIImage(named: image)
	}

	func setuptitle(_ title: String) {
		navigationItem.title = title
	}
	
	func changeSwitchLabel(text: String) {
		placeLabel.text = text
	}
	
	func changeColor(_ color: UIColor) {
		timingButton.layer.borderColor = color.cgColor
		circleLengthButton.layer.borderColor = color.cgColor
	}
	
	func saveTimeResult() {
		presenter.saveTimeResult()
	}
}


