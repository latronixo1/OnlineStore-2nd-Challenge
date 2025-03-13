//
//  AuthViewModel.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    var email: String = ""
    var password: String = ""
    let mainView: LoginView = .init()
    var alertMessage: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        mainView.eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    //MARK: SIGN_IN
    
    @objc func loginButtonTapped() {
        email = mainView.emailTextField.text?.lowercased() ?? ""
        password = mainView.passwordTextField.text ?? ""
        guard !email.isEmpty, !password.isEmpty else {
            print("ошибка авторизации")
            self.showAlert(message: "Заполните все поля")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if let error = error {
                print("Произошла ошибка: \(error.localizedDescription)")
                self.catchError(error: error)
                self.showAlert(message: self.alertMessage )
            } else {
                self.goNextView()
                UserDefaults.standard.set(true, forKey: UserDefaultsStorageKeys.authIsTrue.label)
            }
        }
    }
    //MARK: ALERT

    func catchError(error: Error) {
        if let cathcError = AuthErrorCode(rawValue: error._code) {
            switch cathcError {
            case .invalidEmail: alertMessage = "Неверный email"
            case .wrongPassword: alertMessage = "Неверный пароль"
            case .userNotFound: alertMessage = "Пользователь не найден"
            case .userDisabled: alertMessage = "Пользователь заблокирован"
            case .tooManyRequests: alertMessage = "Слишком много попыток входа"
            case .networkError: alertMessage = "Ошибка сети"
            default: return alertMessage = "Произошла ошибка: \(error.localizedDescription)"
            }
        } else {
            alertMessage = "Неизвестная ошибка"
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    //MARK: NAVIGATION
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    func goNextView(){
        navigationController?.pushViewController(OnboardingViewController(), animated: true)
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
