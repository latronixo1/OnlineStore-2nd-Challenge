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
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    @objc func loginButtonTapped() {
        email = mainView.emailTextField.text ?? ""
        password = mainView.passwordTextField.text ?? ""
        guard !email.isEmpty, !password.isEmpty else {
            self.showAlert(message: "Заполните все поля")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if let error = error {
                print("Ошибка авторизации: \(error.localizedDescription)")
                self.showAlert(message: "\(error.localizedDescription)" )
            } else {
                print("авторизацию успешна надо прописать пуш на след вью")
            }
        }
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
