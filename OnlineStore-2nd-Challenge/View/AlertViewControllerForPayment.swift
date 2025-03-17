//
//  AlertViewControllerForPayment.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 12.03.2025.
//

import UIKit

class CustomAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка фона
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Полупрозрачный черный фон
        
        // Создаем контейнер для Alert
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 20
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем контейнер на экран
        view.addSubview(alertView)
        
        // Устанавливаем констрейнты для контейнера
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 370),
            alertView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        //галка сверху
        let doneImage: RoundImageView = {
            let imageView = RoundImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            //настройка белой рамки
            imageView.layer.borderWidth = 10.0
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.image = UIImage(named: "doneForAlert")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        // Заголовок
        let titleLabel = UILabel()
        titleLabel.text = "Done!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = #colorLiteral(red: 0.2195954621, green: 0.2195341587, blue: 0.2236890793, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.addSubview(doneImage)
        alertView.addSubview(titleLabel)
        
        // Сообщение
        let messageLabel = UILabel()
        messageLabel.text = """
        Your card has been successfully charged.

        """
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(messageLabel)
        
        // Кнопка "OK"
        let trackMyOrderButton = UIButton(type: .system)
        trackMyOrderButton.setTitle("Track My Order", for: .normal)
        trackMyOrderButton.backgroundColor = #colorLiteral(red: 0.9057407379, green: 0.9095990658, blue: 0.9220935702, alpha: 1)
        trackMyOrderButton.setTitleColor(#colorLiteral(red: 0.2195954621, green: 0.2195341587, blue: 0.2236890793, alpha: 1), for: .normal)
        trackMyOrderButton.layer.cornerRadius = 8
        trackMyOrderButton.titleLabel?.font = UIFont(name: "Nunito Sans", size: 20)
        trackMyOrderButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        trackMyOrderButton.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(trackMyOrderButton)
        
        // Устанавливаем констрейнты для элементов
        NSLayoutConstraint.activate([
            
            doneImage.topAnchor.constraint(equalTo: alertView.topAnchor, constant: -30),
            doneImage.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            doneImage.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.2),
            doneImage.heightAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.2),

            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            trackMyOrderButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            trackMyOrderButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 100),
            trackMyOrderButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -100),
            trackMyOrderButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // Метод для закрытия Alert
    @objc func dismissAlert() {
        dismiss(animated: true, completion: nil)
        //здесь нужно очистить корзину
    }
}
