//
//  StartView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//


import UIKit

class StartView: UIView {
    let backGroundCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.white
        circle.layer.cornerRadius = 100
        circle.layer.shadowColor = UIColor.black.cgColor
        circle.layer.shadowOpacity = 0.2
        circle.layer.shadowOffset = CGSize(width: 0, height: 4)
        circle.layer.shadowRadius = 5
        circle.layer.masksToBounds = false
        return circle
    }()
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LaunchScreenImage")
        imageView.contentMode = .center
        imageView.tintColor = .button
        return imageView
    }()
    lazy var nameOfAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Shoppe"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 52, weight: .bold)
        return label
    }()
    lazy var getStartedBtton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's get started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .button
        button.layer.cornerRadius = 16
        return button
    }()
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "I already have an account"
        return label
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronButton"), for: .normal)
        return button
    }()
    lazy var stackForLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView(){
        addSubview(backGroundCircle)
        addSubview(logoImageView)
        addSubview(nameOfAppLabel)
        addSubview(getStartedBtton)
        stackForLogin.addArrangedSubview(loginLabel)
        stackForLogin.addArrangedSubview(loginButton)
        addSubview(stackForLogin)
        
        backGroundCircle.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameOfAppLabel.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtton.translatesAutoresizingMaskIntoConstraints = false
        stackForLogin.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            backGroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            backGroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            backGroundCircle.widthAnchor.constraint(equalToConstant: 200),
            backGroundCircle.heightAnchor.constraint(equalToConstant: 200),

            logoImageView.centerXAnchor.constraint(equalTo: backGroundCircle.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: backGroundCircle.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 81),
            logoImageView.heightAnchor.constraint(equalToConstant: 92),

            nameOfAppLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameOfAppLabel.topAnchor.constraint(equalTo: backGroundCircle.bottomAnchor, constant: 20),
            nameOfAppLabel.heightAnchor.constraint(equalToConstant: 60),

            stackForLogin.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackForLogin.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackForLogin.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.leftAnchor.constraint(equalTo: loginLabel.rightAnchor, constant: 5),

            getStartedBtton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            getStartedBtton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            getStartedBtton.bottomAnchor.constraint(equalTo: stackForLogin.topAnchor, constant: -30),
            getStartedBtton.heightAnchor.constraint(equalToConstant: 60)
        ])
            
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//#Preview {
//    StartView()
//}
