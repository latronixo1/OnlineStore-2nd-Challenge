//
//  SettingViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

enum CustomTextFieldType {
    case userName
    case email
    case password
}

final class CustomTextField: UITextField {
    private let textField: CustomTextFieldType
    private var eyeButton: UIButton?
    
    init(textField: CustomTextFieldType, isPrivate: Bool = false) {
        self.textField = textField
        super.init(frame: .zero)
        
        delegate = self
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 10
        self.tintColor = .gray
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.leftViewMode = .always
        if isPrivate {
            isSecureTextEntry = true
            setupEyeButton()
        }
        
        setupLeftPadding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func setupEyeButton() {
        let buttonSize: CGFloat = 24
        eyeButton = UIButton()
        eyeButton?.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton?.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        eyeButton?.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize + 10, height: buttonSize))
        eyeButton?.frame = CGRect(x: -5, y: 0, width: buttonSize, height: buttonSize)
        buttonContainer.addSubview(eyeButton!)
        
        rightView = buttonContainer
        rightViewMode = .always
    }
    
    @objc private func togglePassword() {
        isSecureTextEntry.toggle()
        eyeButton?.isSelected.toggle()
    }
}

