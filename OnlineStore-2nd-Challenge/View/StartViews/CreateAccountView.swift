//
//  RegistrationView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation
import UIKit


class CreateAccountView: UIView {
    let labelOfView: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        return textField
    }()
    let genderPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        return textField
    }()
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .button
        button.layer.cornerRadius = 16
        return button
    }()
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        return button
    }()
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView(){
        addSubview(labelOfView)
        addSubview(emailTextField)
        addSubview(genderPicker)
        addSubview(passwordTextField)
        addSubview(doneButton)
        addSubview(cancelButton)
        
        labelOfView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            cancelButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            doneButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: 10),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            passwordTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            genderPicker.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 10),
            genderPicker.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            genderPicker.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            genderPicker.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.bottomAnchor.constraint(equalTo: genderPicker.topAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            labelOfView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
