//
//  SettingViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit
import FirebaseAuth
import Firebase

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
    private let genderLabel = UILabel.makeLabel(text: "Выберите пол", font: .systemFont(ofSize: 17, weight: .regular), textColor: .black)
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
    
    private let logoutButton = UIButton()
    private let genders: [String] = ["Man", "Women"]
    private var currentGender = String()
    private let genderSelection = UIPickerView()
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupLayout()
        setupEditPhotoButton()
        setupSaveButton()
        setupLogoutButton()
        setupNavigationBar()
        addTapGestureToHideKeyboard()
        let user = UserDefaultsManager.shared.loadUser()
        updateUserData(
            photo: UIImage(data: user?.photo ?? Data()) ?? UIImage(named: "Image") ?? UIImage(),
            name: user?.name ?? "Ivan",
            email: user?.email ?? "ivan@mail",
            password: user?.password ?? "1234",
            gender: user?.gender ?? "пол не определен"
            
        )
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        genderSelection.delegate = self
        genderSelection.dataSource = self
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        infoLabelName.isHidden = true
        infoLabelEmail.isHidden = true
        infoLabelPassword.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
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
    
    private func updateUserData(photo: UIImage, name: String, email: String, password: String, gender: String) {
        profileImage.image = photo
        nameTextField.text = name
        emailTextField.text = email
        passwordTextField.text = password
        currentGender = gender
        
        if let index = genders.firstIndex(of: gender) {
            genderSelection.selectRow(index, inComponent: 0, animated: false)
        }
        
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
        navigation.addSubview(logoutButton)
        view.addSubview(navigation)
    }
    
    private func setupLogoutButton() {
        logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        logoutButton.tintColor = .black
        logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        
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
    
    @objc func tapLogoutButton() {
        print("Logout button tapped")
        do {
            try Auth.auth().signOut()
            navigationController?.pushViewController(LoginViewController(), animated: true)
            print("LogOut")
        } catch let error {
            print("\(error.localizedDescription)")
        }
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
            infoLabelPassword,
            genderSelection,
            genderLabel,
            logoutButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            navigation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 80),
            
            logoutButton.centerYAnchor.constraint(equalTo: titleOfLabel.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: navigation.trailingAnchor,constant: -12),
            logoutButton.widthAnchor.constraint(equalToConstant: 24),
            logoutButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleOfLabel.leadingAnchor.constraint(equalTo: navigation.leadingAnchor, constant: 24),
            titleOfLabel.topAnchor.constraint(equalTo: navigation.topAnchor, constant: 12),
            titleOfLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: -12),
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
            
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderLabel.centerYAnchor.constraint(equalTo: genderSelection.centerYAnchor),
            
            genderSelection.topAnchor.constraint(equalTo: infoLabelPassword.bottomAnchor, constant: 10),
            //genderSelection.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor, constant: -8),
            genderSelection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            genderSelection.heightAnchor.constraint(equalToConstant: 50),
            genderSelection.widthAnchor.constraint(equalToConstant: 200),
            
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
                password: passwordTextField.text ?? "",
                gender: currentGender
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

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentGender = genders[row]
        
        UserDefaultsManager.shared.saveUser(
            UserData(
                id: 0,
                photo: profileImage.image?.pngData() ?? Data(),
                name: nameTextField.text ?? "",
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? "",
                gender: currentGender
            )
        )
        
        updateSaveButtonState()
    }
}
