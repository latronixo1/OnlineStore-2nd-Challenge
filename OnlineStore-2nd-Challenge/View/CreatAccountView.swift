//
//  RegistrationView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation
import UIKit

class CreatAccountView: UIView {
    lazy var labelOfView: UILabel = {
        let label = UILabel()
        label.text = "Create account"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 54)
        return label
    }()
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        return textField
    }()
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        return textField
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .button
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView(){
        addSubview(labelOfView)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(doneButton)
        addSubview(cancelButton)
        
        labelOfView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            labelOfView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            labelOfView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20),
            labelOfView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            labelOfView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20),
            
            passwordTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -60),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            nameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
