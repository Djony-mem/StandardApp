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
}

	//MARK: - SelectionViewController
class SelectionViewController: UIViewController {
	var presenter: ISelectionPresenter!
	
	private let bgImageView = UIImageView()
	
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
	
	private let resultButton = UIButton()
	
	private let distancesStadium = StadiumEnum.allCases
	private let distancesHighway = HighwayEnum.allCases
	
	private let times = Array(0...59)
	private let miliseconds = Array(0...99)
	
	private var hour = "00"
	private var minute = "00"
	private var second = "00"
	private var millisecond = "00"
	
	private var studium: Place = .stadium
	private var stadium: StadiumEnum = .tenThousandM
	private var highway: HighwayEnum = .oneHundredKM
	private var chronometer: ChronometerEnum = .manual
	private var circleLength: CircleEnum = .none
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	//MARK: - Actions
	@objc
	private func switchAction() {
		presenter.changedSwitchValue(placeSwitch.isOn)
		pickerDistans.reloadAllComponents()
	}
	
	@objc
	private func showResultVC() {
		let timeString = "\(hour):\(minute):\(second):\(millisecond)"
		let time = Time(stringLiteral: timeString)
		
		print(timeString)
	}
}

//MARK: - Settings View
private extension SelectionViewController{
	func setupView() {
		
		view.backgroundColor = ColorSpace.BgColor.mainVC
		addSubviews()
		
		addActions()
		
		setupBgImageView()
		setupPlaceLabel()
		setupPickerDistance()
		setupPickerTime()
		setupResultButton()
		
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
		placeSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
		
		resultButton.addTarget(self, action: #selector(showResultVC), for: .touchUpInside)
	}
	
	func setupBgImageView() {
		bgImageView.image = UIImage(named: "bgSelectV3")
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
	
	func setupResultButton() {
		resultButton.setTitle("Проверить результат", for: .normal)
		resultButton.setTitleColor(
			ColorSpace.ResultButton.titleColor, for: .normal
		)
		resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
		resultButton.layer.cornerRadius = 10
		resultButton.backgroundColor = ColorSpace.ResultButton.bgEnebled
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
			
			timingLabel.topAnchor.constraint(equalTo: pickerDistans.bottomAnchor, constant: 30),
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
			if placeSwitch.isOn {
				return distancesHighway[row].rawValue
			} else {
				setupCircleLengthButton(isEnebledLength: distancesStadium[row].isEnebledCircleLength)
				
				setupTimingButtonMenu(isOnlyManual: distancesStadium[row].isOnlyManual)
				
				setupCircleLengthButtonMenu(isOnly200: distancesStadium[row].isCircleLengthOnly200 )
				
				return distancesStadium[row].rawValue
			}
		} else {
			return component == 3
			? stringConvert(number: miliseconds[row])
			: stringConvert(number: times[row])
		}
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

		if pickerView == pickerDistans {
			if !placeSwitch.isOn {
				setupCircleLengthButton(isEnebledLength: distancesStadium[row].isEnebledCircleLength)
				
				setupTimingButtonMenu(isOnlyManual:  distancesStadium[row].isOnlyManual)
				
				setupCircleLengthButtonMenu(isOnly200: distancesStadium[row].isCircleLengthOnly200)
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
		if pickerView == pickerDistans {
			return 280
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
				UIAction(title: "400 метров", state: .on, handler: {_ in }),
				UIAction(title: "200 метров", handler: {_ in })
			])
		} else {
			circleLengthButton.menu = UIMenu(children: [
				UIAction(title: "200 метров", handler: {_ in })
			])
		}
	}
	
	func setupTimingButtonMenu(isOnlyManual: Bool) {
		if isOnlyManual {
			timingButton.menu = UIMenu(children: [
				UIAction(title: "Ручной", state: .on, handler: {_ in }),
				UIAction(title: "Авто", handler: {_ in })
			])
		} else {
			timingButton.menu = UIMenu(children: [
				UIAction(title: "Ручной", state: .on, handler: {_ in }),
			])
		}
	}
	
	func stringConvert(number: Int) -> String {
		String(format: "%02d", number)
	}
}


//MARK: - SelectionViewProtocol
extension SelectionViewController: ISelectionView {
	func changeSwitchLabel(text: String) {
		placeLabel.text = text
	}
	
	func changeColor(_ color: UIColor) {
		
	}
}

struct SelectionViewControllerProvider: PreviewProvider {
	static var previews: some View {
		SelectionViewController().preview()
	}
}
