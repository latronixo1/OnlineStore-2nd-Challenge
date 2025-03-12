//
//  RegistrationVIewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//
import UIKit
import FirebaseAuth

class CreatAccountViewController: UIViewController {
    let mainView: CreatAccountView = .init()
    var name : String = ""
    var email: String = ""
    var password: String = ""
    var messageForAlert: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        mainView.doneButton.addTarget(self, action: #selector(self.makeUser), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(self.previosView), for: .touchUpInside)
    }
    
    @objc func makeUser() {
        self.email = mainView.emailTextField.text ?? ""
        self.password = mainView.passwordTextField.text ?? ""
        self.name = mainView.nameTextField.text ?? ""
        
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
            showAlert(message: "Заполните все поля.")
            return
            }

        guard email.contains("@") else {
            showAlert(message: "Некорректный email.")
            return
            }

        guard password.count >= 6 else {
            showAlert(message: "Пароль должен содержать минимум 6 символов.")
            return
            }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.makeAlertMessage(error: error)
                self.showAlert(message: self.messageForAlert)
                print("\(error.localizedDescription)")
            } else {
                
            UserDefaults.standard.set(self.name, forKey: UserDefaultsStorageKeys.name.label)
                UserDefaults.standard.set(self.email, forKey: UserDefaultsStorageKeys.email.label)
                UserDefaults.standard.set(self.password, forKey: UserDefaultsStorageKeys.password.label)
                //тут гендер добавить
                self.goToLoginView()
            }
            
        }
    }
    func makeAlertMessage(error: Error) {
        messageForAlert = ""
        if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode {
                case .invalidEmail:
                    messageForAlert = "Некорректный email."
                case .emailAlreadyInUse:
                    messageForAlert = "Email уже используется."
                case .weakPassword:
                    messageForAlert = "Пароль слишком слабый. Минимум 6 символов."
                case .userDisabled:
                    messageForAlert = "Пользователь отключен."
                case .userNotFound:
                    messageForAlert = "Пользователь не найден."
                case .wrongPassword:
                    messageForAlert = "Неверный пароль."
                case .tooManyRequests:
                    messageForAlert = "Слишком много попыток. Попробуйте позже."
                default:
                    messageForAlert = "Произошла ошибка: \(error.localizedDescription)"
                }
            } else {
                messageForAlert = "Произошла неизвестная ошибка."
            }
    }
    
    // MARK: Navigation
    func goToLoginView() {
        let view = LoginViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    @objc func previosView() {
        navigationController?.popViewController(animated: true)
        
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
