//
//  PaymentViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 06.03.2025.
//

import UIKit

class PaymentViewController: UIViewController {
    
    // MARK: - Variables
    
    private var countItems: Int = 1
    private var idItems: [Int]? = [1]
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let navigation: UINavigationBar = {
        let element = UINavigationBar()
        element.barTintColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let titleOfLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 30

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
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
        view.backgroundColor = .white
        
        setupViews()
        setConstraints()
    }

    // MARK: - UI Setup
    
    private func setupViews() {
        
        navigationItem.hidesBackButton = false
        view.addSubview(navigation)
        navigation.addSubview(titleOfLabel)
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        backButton.tintColor = .black

//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
//        backButton.
        navigationItem.leftBarButtonItem = backButton



        // Добавляем ScrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Добавляем компоненты в contentView
        mainStackView.addArrangedSubview(createGrayView(title: "Shipping Address", text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city"))
        mainStackView.addArrangedSubview(createGrayView(title: "Contact Information", text: "+84932000000\namandamorgan@example.com"))
        mainStackView.addArrangedSubview(createItemsView())
//        mainStackView.addArrangedSubview(createSectionTitle("Items 2"))
//        mainStackView.addArrangedSubview(itemsLabel)
//        mainStackView.addArrangedSubview(createSeparator())
        mainStackView.addArrangedSubview(createSectionTitle("Shipping Options"))
        mainStackView.addArrangedSubview(shippingOptionsLabel)
        mainStackView.addArrangedSubview(createSeparator())
        mainStackView.addArrangedSubview(createSectionTitle("Payment Method"))
        mainStackView.addArrangedSubview(paymentMethodLabel)
        mainStackView.addArrangedSubview(createSeparator())
        mainStackView.addArrangedSubview(totalLabel)
        mainStackView.addArrangedSubview(payButton)
        
        contentView.addSubview(mainStackView)

        // Добавляем действие для кнопки Pay
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Set Constraints
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            navigation.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 60),
            
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

            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            payButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Helper Methods

    private func createSectionTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }
    private func createGrayView(title: String, text: String) -> UIView {
        let grayView: UIView = {
            let element = UIView()
            element.backgroundColor = #colorLiteral(red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
            element.layer.cornerRadius = 2
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        let stackView: UIStackView = {
            let element = UIStackView()
            element.axis = .vertical
            element.spacing = 5
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        let titleLabel: UILabel = {
            let element = UILabel()
            element.text = title
            element.numberOfLines = 1
            element.font = UIFont.boldSystemFont(ofSize: 16)
            element.textColor = .black
            return element
        }()
        let textLabel: UILabel = {
            let element = UILabel()
            element.text = text
            element.numberOfLines = 0
            element.font = UIFont.boldSystemFont(ofSize: 10)
            element.textColor = .darkGray
            return element
        }()
        let editShippingButton: RoundButton = {
            let element = RoundButton()
            // Создаем конфигурацию для увеличения размера изображения
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let pencilImage = UIImage(systemName: "pencil", withConfiguration: largeConfig)
            
            element.setImage(pencilImage, for: .normal)
            element.backgroundColor = #colorLiteral(red: 0, green: 0.2947360277, blue: 0.9967841506, alpha: 1)
            element.tintColor = .white
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()

        grayView.addSubview(stackView)
        grayView.addSubview(editShippingButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: grayView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 7),
            stackView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalToConstant: 70),

            editShippingButton.trailingAnchor.constraint(equalTo: grayView.trailingAnchor),
            editShippingButton.bottomAnchor.constraint(equalTo: grayView.bottomAnchor),
            editShippingButton.widthAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.1),
            editShippingButton.heightAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.1),
            
        ])
        return grayView
    }
    
    private func createItemsView() -> UIView {
        let itemsView: UIView = {
            let element = UIView()
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleItemsView: UIView = {
            let element = UIView()
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleLabel: UILabel = {
            let element = UILabel()
            element.text = title
            element.numberOfLines = 1
            element.font = UIFont.boldSystemFont(ofSize: 16)
            element.textColor = .black
            return element
        }()
        let countItemsInCart: RoundLabel = {
            let element = RoundLabel()
            element.backgroundColor = #colorLiteral(red: 0.8971917033, green: 0.9204418063, blue: 0.9870311618, alpha: 1)
            element.tintColor = .black
            element.textAlignment = .center
            element.font = UIFont.boldSystemFont(ofSize: 16)
            element.textColor = .black
            element.text = String(countItems)
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        let addVaucherButton: UIButton = {
            let element = UIButton()
            element.setTitle("Add Voucher", for: .normal)
            element.layer.cornerRadius = 10
            element.backgroundColor = .white
            element.layer.borderWidth = 1
            element.layer.borderColor = #colorLiteral(red: 0, green: 0.2947360277, blue: 0.9967841506, alpha: 1)
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        itemsView.addSubview(titleItemsView)
        titleItemsView.addSubview(titleLabel)
        titleItemsView.addSubview(countItemsInCart)
        titleItemsView.addSubview(addVaucherButton)
        
        NSLayoutConstraint.activate([
            
            titleItemsView.topAnchor.constraint(equalTo: itemsView.topAnchor),
            titleItemsView.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor),
            titleItemsView.heightAnchor.constraint(equalToConstant: 30),
            titleItemsView.widthAnchor.constraint(equalTo: itemsView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleItemsView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleItemsView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleItemsView.widthAnchor, multiplier: 0.2),
            titleLabel.heightAnchor.constraint(equalTo: titleItemsView.heightAnchor),
            
            countItemsInCart.topAnchor.constraint(equalTo: titleItemsView.topAnchor),
            countItemsInCart.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            countItemsInCart.heightAnchor.constraint(equalTo: titleItemsView.heightAnchor),
            
            addVaucherButton.topAnchor.constraint(equalTo: titleItemsView.topAnchor),
            addVaucherButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            addVaucherButton.heightAnchor.constraint(equalTo: titleItemsView.heightAnchor),

            ])
        
        return itemsView
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

//следующий код необходим, чтобы сделать кнопку круглой, если мы не знаем ее размеров
class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true  //обрезаем содержимое по границам
    }
}

//следующий код необходим, чтобы сделать вьюху круглой, если мы не знаем ее размеров
class RoundLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2.0
        layer.masksToBounds = true  //обрезаем содержимое по границам
    }
}
