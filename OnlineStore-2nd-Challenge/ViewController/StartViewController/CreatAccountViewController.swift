//
//  RegistrationVIewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//
import UIKit
import FirebaseAuth

class CreatAccountViewController: UIViewController {
    private let mainView: CreateAccountView = .init()
    private let pickerData: [String] = ["", "Мужской","Женский"]
    private var gender: String = ""
    private var email: String = ""
    private var password: String = ""
    private var showALert: Bool = false
    private var alertMessage: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.genderPicker.delegate = self
        mainView.genderPicker.dataSource = self
        mainView.backgroundColor = .white
        mainView.doneButton.addTarget(self, action: #selector (doneButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector (cancelButtonTapped), for: .touchUpInside)
        mainView.eyeButton.addTarget(self, action: #selector (togglePasswordVisibility), for: .touchUpInside)
        
    }
    
    //MARK: CREATE_USER
    
    @objc func doneButtonTapped() {
        print("Кнопка Done")
        self.email = mainView.emailTextField.text?.lowercased() ?? ""
        self.password = mainView.passwordTextField.text ?? ""
        guard self.email != "" && self.password != "" && gender != ""  else {
            self.alertMessage = "Заполните все поля"
            self.makeShowAlert(on: self, title: "Ошибка", message: self.alertMessage)
            return
        }
        Auth.auth().createUser(withEmail: self.email, password: self.password){ result, error in
            if let error = error {
                self.makeAlertMessage(error: error)
                self.makeShowAlert(on: self, title: "Ошибка", message: self.alertMessage)
                print("ошибка регистрации")
            } else {
                UserDefaults.standard.set("\(self.email)", forKey: UserDefaultsStorageKeys.email.label)
                UserDefaults.standard.set("\(self.gender)", forKey: UserDefaultsStorageKeys.gender.label)
                UserDefaults.standard.set("\(self.password)", forKey: UserDefaultsStorageKeys.password.label)
                self.nextView()
            }
        }
    }
    
    //MARK: NAVIGATION

    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func nextView() {
        let nextVc = LoginViewController()
        navigationController?.pushViewController(nextVc, animated: true)
    }
    
    //MARK: ALERT
    
    func makeAlertMessage(error: Error) {
        self.alertMessage = ""
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .invalidEmail:
                self.alertMessage = "Некорректный email."
            case .emailAlreadyInUse:
                self.alertMessage = "Email уже используется."
            case .weakPassword:
                self.alertMessage = "Пароль слишком слабый. Минимум 6 символов."
            case .userDisabled:
                self.alertMessage = "Пользователь отключен."
            case .userNotFound:
                self.alertMessage = "Пользователь не найден."
            case .wrongPassword:
                self.alertMessage = "Неверный пароль."
            case .tooManyRequests:
                self.alertMessage = "Слишком много попыток. Попробуйте позже."
            default:
                self.alertMessage = "Произошла ошибка: \(error.localizedDescription)"
            }
        } else {
            self.alertMessage = "Произошла неизвестная ошибка."
        }
       }

    func makeShowAlert(on viewController: UIViewController, title: String, message: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !actions.isEmpty {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    //MARK: VISABLE_PASS

    @objc private func togglePasswordVisibility() {
        self.mainView.passwordTextField.isSecureTextEntry.toggle()
        if self.mainView.passwordTextField.isSecureTextEntry {
            self.mainView.eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.mainView.eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    
}
extension CreatAccountViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    
}
extension CreatAccountViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.gender = self.pickerData[row]
        print("Выбрана строка \(row) в компоненте \(component)")
    }
}
