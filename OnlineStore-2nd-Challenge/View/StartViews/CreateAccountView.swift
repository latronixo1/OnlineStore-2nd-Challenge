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
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    let backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CreateView")
        return imageView
    }()
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 30
        textField.borderStyle = .roundedRect
        textField.clipsToBounds = true
        return textField
    }()
    let genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .systemGray6
        picker.layer.cornerRadius = 30
        picker.clipsToBounds = true
        return picker
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 30
        textField.borderStyle = .roundedRect
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        return textField
    }()
    let eyeButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal) // Изначально глаз закрыт
            button.tintColor = UIColor.systemGray
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            return button
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
        addSubview(backGroundImage)
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        
        backGroundImage.translatesAutoresizingMaskIntoConstraints = false
        labelOfView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            cancelButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            doneButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            passwordTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -60),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            genderPicker.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            genderPicker.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            genderPicker.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            genderPicker.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.bottomAnchor.constraint(equalTo: genderPicker.topAnchor, constant: -10),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            labelOfView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            labelOfView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            labelOfView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            labelOfView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            backGroundImage.topAnchor.constraint(equalTo: topAnchor),
            backGroundImage.leftAnchor.constraint(equalTo: leftAnchor),
            backGroundImage.rightAnchor.constraint(equalTo: rightAnchor),
            
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
