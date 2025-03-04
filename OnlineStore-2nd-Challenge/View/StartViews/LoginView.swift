//
//  File.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import UIKit

class LoginView: UIView {
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    lazy var littleLabel: UILabel = {
        let label = UILabel()
        label.text = "Good to see you back"
        label.font = .systemFont(ofSize: 19, weight: .light)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Password"
        txtField.backgroundColor = .systemGray6
        txtField.layer.cornerRadius = 20
        return txtField
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .button
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView(){
        addSubview(loginLabel)
        addSubview(littleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(cancelButton)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        littleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20),
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            littleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -20),
            littleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            littleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            loginLabel.bottomAnchor.constraint(equalTo: littleLabel.topAnchor, constant: -10),
            loginLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            loginLabel.heightAnchor.constraint(equalToConstant: 60) ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
