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
    private let pickerData: [String] = ["Мужской","Женский"]
    private var gender: String = ""
    private var email: String = ""
    private var password: String = ""
    private var showALert: Bool = false
    private var alertMessage: String = ""
    
    override func loadView() {
        self.view = mainView
        mainView.doneButton.addTarget(self, action: #selector (doneButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector (cancelButtonTapped), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.genderPicker.delegate = self
        mainView.genderPicker.dataSource = self
        mainView.backgroundColor = .white
        
    }
    @objc func doneButtonTapped() {
        self.email = mainView.emailTextField.text ?? ""
        self.password = mainView.emailTextField.text ?? ""
        guard self.email != "" && self.password != "" && gender != ""  else {
            self.showALert = true
            self.alertMessage = "Заполните все поля"
            return
        }
        Auth.auth().createUser(withEmail: self.email, password: self.password){ result, error in
            if let error = error {
                makeAlertMessage(error: error)
                self.showALert = true
                print("ошибка регистрации")
            } else {
                UserDefaults.standard.set("\(self.email)", forKey: UserDefaultsStorageKeys.email.label)
                UserDefaults.standard.set("\(self.gender)", forKey: UserDefaultsStorageKeys.gender.label)
                UserDefaults.standard.set("\(self.password)", forKey: UserDefaultsStorageKeys.password.label)
                self.nextView()
            }
            
            
            
        }
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
        
    }
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func nextView() {
        let nextVc = LoginViewController()
        navigationController?.pushViewController(nextVc, animated: true)
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
