//
//  SettingViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

final class SettingViewController: UIViewController {
    //MARK: - Private Property
    private let editPhotoButton = CustomEditButton(image: UIImage(resource: .button))
    private let profileImage = UIImageView.makeImage(
        named: "Image",
        cornerRadius: 50,
        heightAnchor: 100,
        widthAnchor: 100,
        border: true,
        shadow: true
    )
    private let nameTextField = CustomTextField(textField: .userName, isPrivate: false)
    private let emailTextField = CustomTextField(textField: .email, isPrivate: false)
    private let passwordTextField = CustomTextField(textField: .password, isPrivate: true)
    private let buttonSave = CustomButton(
        title: "Save Changes",
        backgroundColor: .systemBlue,
        textColor: .white,
        fontSize: .big
    )
    private let infoLabelName = UILabel.makeLabel(text: "Имя не может быть пустым", font: .systemFont(ofSize: 14, weight: .regular), textColor: .red)
    private let infoLabelEmail = UILabel.makeLabel(text: "Email не может быть пустым", font: .systemFont(ofSize: 14, weight: .regular), textColor: .red)
    private let infoLabelPassword = UILabel.makeLabel(text: "Пароль не может быть пустым", font: .systemFont(ofSize: 14, weight: .regular), textColor: .red)
    private let navigation = UINavigationBar()
    private let titleOfLabel = UILabel.makeLabel(
        text: "Settings",
        font: .systemFont(ofSize: 28, weight: .bold),
        textColor: .black
    )
    private let subTitleOfLabel = UILabel.makeLabel(
        text: "Your Profile",
        font: .systemFont(ofSize: 16, weight: .medium),
        textColor: .black
    )
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupLayout()
        setupEditPhotoButton()
        setupSaveButton()
        setupNavigationBar()
        addTapGestureToHideKeyboard()
        let user = UserDefaultsManager.shared.loadUser()
        updateUserData(
            photo: UIImage(data: user?.photo ?? Data()) ?? UIImage(named: "Image") ?? UIImage(),
            name: user?.name ?? "Ivan",
            email: user?.email ?? "ivan@mail",
            password: user?.password ?? "1234"
        )
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        infoLabelName.isHidden = true
        infoLabelEmail.isHidden = true
        infoLabelPassword.isHidden = true
        
    }
    
    //MARK: - Private methods
    //скрывает клавиатуру по нажатию на внешнюю область
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapGesture() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func updateUserData(photo: UIImage, name: String, email: String, password: String) {
        profileImage.image = photo
        nameTextField.text = name
        emailTextField.text = email
        passwordTextField.text = password
    }
    
    private func updateSaveButtonState() {
        let isNameFilled = !(nameTextField.text?.isEmpty ?? true)
        let isEmailFilled = !(emailTextField.text?.isEmpty ?? true)
        let isPasswordFilled = !(passwordTextField.text?.isEmpty ?? true)
        
        let isEnabled = isNameFilled || isEmailFilled || isPasswordFilled
        buttonSave.isEnabled = isEnabled
        buttonSave.backgroundColor = isEnabled ? .systemBlue : .lightGray
    }
    
    
    func setupNavigationBar() {
        navigation.barTintColor = .white
        navigation.addSubview(titleOfLabel)
        navigation.addSubview(subTitleOfLabel)
        view.addSubview(navigation)
    }
    
    private func setupSaveButton() {
        buttonSave.isEnabled = false
        buttonSave.backgroundColor = .lightGray
        buttonSave.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
    }
    
    private func setupEditPhotoButton() {
        editPhotoButton.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
    }
    
    @objc func tapSaveButton() {
        saveUserInfo()
        buttonSave.backgroundColor = .lightGray
        print("button save tapped")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func tapEditButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("button edit tapped")
    }
}

private extension SettingViewController {
    func setup() {
        [
            profileImage,
            nameTextField,
            emailTextField,
            passwordTextField,
            editPhotoButton,
            buttonSave,
            navigation,
            titleOfLabel,
            subTitleOfLabel,
            infoLabelName,
            infoLabelEmail,
            infoLabelPassword
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            navigation.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 80),
            
            titleOfLabel.leadingAnchor.constraint(equalTo: navigation.leadingAnchor, constant: 24),
            titleOfLabel.topAnchor.constraint(equalTo: navigation.topAnchor, constant: 12),
            titleOfLabel.trailingAnchor.constraint(equalTo: navigation.trailingAnchor, constant: -12),
            titleOfLabel.heightAnchor.constraint(equalToConstant: 36),
            
            subTitleOfLabel.topAnchor.constraint(equalTo: titleOfLabel.bottomAnchor, constant: 8),
            subTitleOfLabel.leadingAnchor.constraint(equalTo: titleOfLabel.leadingAnchor),
            subTitleOfLabel.trailingAnchor.constraint(equalTo: titleOfLabel.trailingAnchor),
            
            profileImage.topAnchor.constraint(equalTo: navigation.bottomAnchor, constant: 50),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            editPhotoButton.widthAnchor.constraint(equalToConstant: 30),
            editPhotoButton.heightAnchor.constraint(equalToConstant: 30),
            editPhotoButton.bottomAnchor.constraint(equalTo: profileImage.topAnchor, constant: 26),
            editPhotoButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -4),
            
            nameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabelName.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 4),
            infoLabelName.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            infoLabelName.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            infoLabelName.heightAnchor.constraint(equalToConstant: 16),
            
            emailTextField.topAnchor.constraint(equalTo: infoLabelName.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabelEmail.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            infoLabelEmail.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            infoLabelEmail.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            infoLabelEmail.heightAnchor.constraint(equalToConstant: 16),
            
            passwordTextField.topAnchor.constraint(equalTo: infoLabelEmail.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabelPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            infoLabelPassword.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            infoLabelPassword.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            infoLabelPassword.heightAnchor.constraint(equalToConstant: 16),
            
            buttonSave.heightAnchor.constraint(equalToConstant: 40),
            buttonSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonSave.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImage.image = image
        }
        picker.dismiss(animated: true)
        buttonSave.backgroundColor = .systemBlue
        saveUserInfo()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func saveUserInfo() {
        UserDefaultsManager.shared.saveUser(
            UserData(
                id: 0,
                photo: profileImage.image?.pngData() ?? Data(),
                name: nameTextField.text ?? "",
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
        )
    }
}


extension SettingViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async { [weak self] in
            self?.updateSaveButtonState()
        }
        
        return true
    }
    
    //если поле пустое отображает лейблы с ошибками
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        
        if text.isEmpty {
            if textField == nameTextField {
                infoLabelName.isHidden = false
            } else if textField == emailTextField {
                infoLabelEmail.isHidden = false
            } else if textField == passwordTextField {
                infoLabelPassword.isHidden = false
            }
            return false
        }
        return true
    }
    
    //скрывает клавиатуру по нажатию на done
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        let text = scoreText.text ?? ""
        
        if !text.isEmpty {
            if scoreText == nameTextField {
                infoLabelName.isHidden = true
            } else if scoreText == emailTextField {
                infoLabelEmail.isHidden = true
            } else if scoreText == passwordTextField {
                infoLabelPassword.isHidden = true
            }
        }
        scoreText.resignFirstResponder()
        return true
    }
    
    //при вводе текста скрывает лейблы с ошибками
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if !text.isEmpty {
            if textField == nameTextField {
                infoLabelName.isHidden = true
            } else if textField == emailTextField {
                infoLabelEmail.isHidden = true
            } else if textField == passwordTextField {
                infoLabelPassword.isHidden = true
            }
        }
        
    }
}
