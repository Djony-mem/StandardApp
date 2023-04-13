	//
	//  RegisterViewController.swift
	//  StandardApp
	//
	//  Created by brubru on 26.12.2022.
	//

import UIKit

protocol INewAthleteView: AnyObject {
	
}

	//MARK: - NewAthleteViewController
class NewAthleteViewController: UIViewController {
	
	var presenter: NewAthletePresenter!
	
	private var viewModel: ViewModel?
	
	private let bgImageView = UIImageView()
	private let nikNameTextField = CustomTextField(placeholder: "Введите ваш ник")
	private let genderPickerView = UIPickerView()
	private let saveButton = ResultButton(title: "Сохранить")
	
	private let gender = Gender.allCases
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	// MARK: - Actions
	@objc
	private func pushSaveButton() {
		presenter.sendViewModel()
	}
}

	//MARK: - Settings View
private extension NewAthleteViewController {
	func setupView() {
		view.backgroundColor = ColorSpace.BgColor.navigation

		addSubViews()
		addActions()
		
		setupNikNameTextField()
		setupGenderPicker()
		setupBgImageView()
		
		setupLayout()
	}
}

	//MARK: - Setting
private extension NewAthleteViewController {
	func addSubViews() {
		[bgImageView, nikNameTextField, genderPickerView, saveButton].forEach { subView in
			view.addSubview(subView)
		}
	}
	
	func addActions() {
		saveButton.addTarget(
			self,
			action: #selector(pushSaveButton),
			for: .touchUpInside
		)
	}
	
	func setupNikNameTextField() {
		nikNameTextField.delegate = self
		
		if let viewModel {
			nikNameTextField.text = viewModel.nikName
		}
	}
	
	func setupGenderPicker() {
		genderPickerView.delegate = self
		genderPickerView.dataSource = self
		
		if let viewModel {
			guard let index = gender.firstIndex(of: viewModel.gender) else { return }
			genderPickerView.selectRow(index, inComponent: 0, animated: true)
		}
	}
	
	func setupBgImageView() {
		bgImageView.image = UIImage(named: "bgSelectV3")
	}
}

	//MARK: - Layout
private extension NewAthleteViewController {
	func setupLayout() {
		[bgImageView, nikNameTextField, genderPickerView, saveButton].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		
		NSLayoutConstraint.activate([
			bgImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
			bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
			bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
			bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
			
			nikNameTextField.topAnchor.constraint(equalTo: bgImageView.topAnchor, constant: 50),
			nikNameTextField.centerXAnchor.constraint(equalTo: bgImageView.centerXAnchor),
			nikNameTextField.widthAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 0.7),
			
			genderPickerView.centerXAnchor.constraint(equalTo: bgImageView.centerXAnchor),
			genderPickerView.centerYAnchor.constraint(equalTo: bgImageView.centerYAnchor),
			genderPickerView.widthAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 0.5),
			
			saveButton.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: -100),
			saveButton.centerXAnchor.constraint(equalTo: bgImageView.centerXAnchor),
			saveButton.widthAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 0.5)
		])
	}
}

	//MARK: - UIPickerViewDelegate
extension NewAthleteViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		gender[row].rawValue
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		presenter.chooseGender(gender[row])
		print(gender[row])
	}
}

	//MARK: - UIPickerViewDataSource
extension NewAthleteViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		gender.count
	}
}

	//MARK: - UITextFieldDelegate
extension NewAthleteViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return true
	}
	
	func textFieldDidChangeSelection(_ textField: UITextField) {
		guard let text = textField.text else { return }
		presenter.enteredNikName(text)
	}
}

	//MARK: - INewAthleteView
extension NewAthleteViewController: INewAthleteView {
	
}
