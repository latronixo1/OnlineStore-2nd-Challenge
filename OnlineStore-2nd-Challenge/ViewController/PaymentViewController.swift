//
//  PaymentViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 06.03.2025.
//

import UIKit

class PaymentViewController: UIViewController {

    // MARK: - UI Components
    
    private let navigation = UINavigationBar()
    
    lazy var titleOfLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let shippingAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping Address\n26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let contactInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Information\n+84932000000\namandamorgan@example.com"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "Items 2\n1. Lorem ipsum dolor sit amet consectetur.\n   $17,00\n\n1. Lorem ipsum dolor sit amet consectetur.\n   $17,00"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let shippingOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping Options\n- [ ] Standard 5-7 days\n  FREE\n\n- [ ] Express 1-2 days\n  $12,00\n\nDelivered on or before Thursday, 23 April 2020"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment Method\n- [ ] Card"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total $34,00"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupLayout()
    }

    // MARK: - UI Setup
//
//    private lazy var titleLabel: UILabel = {
//        let element = UILabel()
//        
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//
    
    func setupNavigationBar() {
        navigation.barTintColor = .white
        navigation.addSubview(titleOfLabel)
        view.addSubview(navigation)
    }

    private func setupTitle() {
        
        
        //title = "Payment"
        // Создаем UILabel для title
        let titleLabel = UILabel()
        titleLabel.text = "Payment3"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        
        titleLabel.textAlignment = .left
        
        //let leftTitleLabelItem = UIBarButtonItem(customView: <#T##UIView#>)

    }

    
    private func setupUI() {
        view.backgroundColor = .white

        // Добавляем ScrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Добавляем компоненты в contentView
        let stackView = UIStackView(arrangedSubviews: [
            createSectionTitle("Shipping Address"),
            shippingAddressLabel,
            createSeparator(),
            createSectionTitle("Contact Information"),
            contactInfoLabel,
            createSeparator(),
            createSectionTitle("Items 2"),
            itemsLabel,
            createSeparator(),
            createSectionTitle("Shipping Options"),
            shippingOptionsLabel,
            createSeparator(),
            createSectionTitle("Payment Method"),
            paymentMethodLabel,
            createSeparator(),
            totalLabel,
            payButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        // Настройка констрейнтов
        NSLayoutConstraint.activate([
            navigation.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 80),
            
            titleOfLabel.leadingAnchor.constraint(equalTo: navigation.leadingAnchor, constant: 16),
            titleOfLabel.centerYAnchor.constraint(equalTo: navigation.centerYAnchor),


            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            payButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Добавляем действие для кнопки Pay
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }

    // MARK: - Helper Methods

    private func createSectionTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }

    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }

    // MARK: - Actions

    @objc private func payButtonTapped() {
        // Обработка нажатия на кнопку Pay
        print("Pay button tapped")
    }
}

private extension PaymentViewController {
    func setupLayout() {
        navigation.translatesAutoresizingMaskIntoConstraints = false
        titleOfLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        ])
    }
}
