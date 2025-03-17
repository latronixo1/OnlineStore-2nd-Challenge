//
//  PaymentViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 06.03.2025.
//

import UIKit

class PaymentViewController: UIViewController {
    
    // MARK: - Variables
    
    var cartItems: [Product] = FavoriteManager.shared.loadCartProducts()
    private let favoriteManager = FavoriteManager.shared
    var totalAmount: Double = 0.00
    
    init(_ cartItems: [Product], totalAmount: Double) {
        self.cartItems = cartItems
        self.totalAmount = totalAmount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        //значение по умолчанию
        //        cartItems = [
        //            CartItem(imageName: "Image", title: "Lorem ipsum dolor sit amet consectetur.", price: "$99,00", quantity: 2),
        //            CartItem(imageName: "Image", title: "Lorem ipsum dolor sit amet consectetur.", price: "$99,00", quantity: 1)
        //        ]
        fatalError("init(coder:) has not been implemented")
    }
    
    let shippingOptions: [ShippingOption] = [
        ShippingOption(name: "Standard", duration: "5-7 days", price: "FREE"),
        ShippingOption(name: "Express", duration: "1-2 days", price: "$12,00")
    ]
    
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
        element.spacing = 10
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let deliveryDateLabel: UILabel = {
        let element = UILabel()
        element.text = "It will be delivered on"
        element.textAlignment = .left
        element.font = UIFont.boldSystemFont(ofSize: 12)
        element.textColor = .darkGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //    private let shippingOptionsLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Shipping Options\n- [ ] Standard 5-7 days\n  FREE\n\n- [ ] Express 1-2 days\n  $12,00\n\nDelivered on or before Thursday, 23 April 2020"
    //        label.numberOfLines = 0
    //        label.font = UIFont.systemFont(ofSize: 14)
    //        label.textColor = .darkGray
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    //    private let paymentMethodLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Payment Method\n- [ ] Card"
    //        label.numberOfLines = 0
    //        label.font = UIFont.systemFont(ofSize: 16)
    //        label.textColor = .darkGray
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    //    private let totalLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Total $34,00"
    //        label.font = UIFont.boldSystemFont(ofSize: 18)
    //        label.textColor = .black
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupCollectionView()
        setupViews()
        setConstraints()
        
        DispatchQueue.main.async {
            self.reloadCartProducts()
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTotalAmountLabel()
        print("общая сумма\(totalAmount)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Выбираем первый способ доставки (Standard) после загрузки данных
        let firstItemPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstItemPath, animated: false, scrollPosition: .left)
        
        // Обновляем дату доставки
        deliveryDateLabel.text = "It will be delivered on " + afterNDays(7)

    }
    
    func reloadCartProducts() {
        cartItems = favoriteManager.cartArray
        updateTotalAmountLabel()
        print("добавленные товары \(cartItems.count)")
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
        
        navigationItem.leftBarButtonItem = backButton
        
        
        
        // Добавляем ScrollView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Добавляем компоненты в contentView
        mainStackView.addArrangedSubview(createGrayView(title: "Shipping Address", text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city"))
        mainStackView.addArrangedSubview(createGrayView(title: "Contact Information", text: "+84932000000\namandamorgan@example.com"))
        mainStackView.addArrangedSubview(createItemsView())
        mainStackView.addArrangedSubview(createShippingView())
        setupCollectionView()
        mainStackView.addArrangedSubview(createPaymentMethodView())
        mainStackView.addArrangedSubview(createTotalView())
        
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    private func createGrayView(title: String, text: String) -> UIView {
        let grayView: UIView = {
            let element = UIView()
            element.backgroundColor = #colorLiteral(red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
            element.layer.cornerRadius = 10
            
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
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        let textLabel: UILabel = {
            let element = UILabel()
            element.text = text
            element.numberOfLines = 0
            element.font = UIFont.boldSystemFont(ofSize: 10)
            element.textColor = .darkGray
            element.translatesAutoresizingMaskIntoConstraints = false
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
            grayView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: grayView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 7),
            stackView.widthAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            editShippingButton.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -10),
            editShippingButton.bottomAnchor.constraint(equalTo: grayView.bottomAnchor),
            editShippingButton.widthAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.08),
            editShippingButton.heightAnchor.constraint(equalTo: grayView.widthAnchor, multiplier: 0.08),
            
        ])
        return grayView
    }
    
    //создание раздела с товарами
    func createItemsView() -> UIView {
        let itemsView: UIView = {
            let element = UIView()
            //element.backgroundColor = .yellow
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleItemsStackView: UIStackView = {
            let element = UIStackView()
            element.axis = .horizontal
            //element.backgroundColor = .systemPink
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleLabel: UILabel = {
            let element = UILabel()
            element.text = "Items"
            element.numberOfLines = 1
            element.font = UIFont.boldSystemFont(ofSize: 20)
            element.textColor = .black
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        let countItemsInCart: RoundLabel = {
            let element = RoundLabel()
            element.backgroundColor = #colorLiteral(red: 0.8971917033, green: 0.9204418063, blue: 0.9870311618, alpha: 1)
            element.tintColor = .black
            element.textAlignment = .center
            element.font = UIFont.boldSystemFont(ofSize: 16)
            element.textColor = .black
            element.text = String(cartItems.count)
            
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
            element.setTitleColor(#colorLiteral(red: 0, green: 0.2947360277, blue: 0.9967841506, alpha: 1), for: .normal)
            element.titleLabel?.font = UIFont(name: "SFProRounded-Black", size: 20)
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        itemsView.addSubview(titleItemsStackView)
        titleItemsStackView.addArrangedSubview(titleLabel)
        titleItemsStackView.addArrangedSubview(countItemsInCart)
        titleItemsStackView.addArrangedSubview(addVaucherButton)
        
        itemsView.addSubview(tableView)
        NSLayoutConstraint.activate([
            
            itemsView.heightAnchor.constraint(equalToConstant: CGFloat(cartItems.count * 75 + 50)),
            
            titleItemsStackView.topAnchor.constraint(equalTo: itemsView.topAnchor),
            titleItemsStackView.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor),
            titleItemsStackView.heightAnchor.constraint(equalToConstant: 35),
            titleItemsStackView.widthAnchor.constraint(equalTo: itemsView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleItemsStackView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleItemsStackView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleItemsStackView.widthAnchor, multiplier: 0.15),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            countItemsInCart.topAnchor.constraint(equalTo: titleItemsStackView.topAnchor),
            countItemsInCart.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            countItemsInCart.heightAnchor.constraint(equalTo: titleItemsStackView.widthAnchor, multiplier: 0.08),
            countItemsInCart.widthAnchor.constraint(equalTo: titleItemsStackView.widthAnchor, multiplier: 0.08),
            
            addVaucherButton.topAnchor.constraint(equalTo: titleItemsStackView.topAnchor),
            addVaucherButton.trailingAnchor.constraint(equalTo: titleItemsStackView.trailingAnchor),
            addVaucherButton.heightAnchor.constraint(equalTo: titleItemsStackView.heightAnchor),
            addVaucherButton.widthAnchor.constraint(equalTo: titleItemsStackView.widthAnchor, multiplier: 0.3),
            
            tableView.topAnchor.constraint(equalTo: titleItemsStackView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: itemsView.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 0),
            //tableView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        return itemsView
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: 50, height: 30)
        //
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func createShippingView() -> UIView {
        let shippingView: UIView = {
            let element = UIView()
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let shippingStackView: UIStackView = {
            let element = UIStackView()
            element.axis = .vertical
            element.distribution = .fill
            element.spacing = 2
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleLabel: UILabel = {
            let element = UILabel()
            element.text = "Shipping Options"
            element.textAlignment = .left
            element.font = UIFont.boldSystemFont(ofSize: 20)
            element.textColor = .black
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        shippingView.addSubview(shippingStackView)
        shippingStackView.addArrangedSubview(titleLabel)
        shippingStackView.addArrangedSubview(collectionView)
        shippingStackView.addArrangedSubview(deliveryDateLabel)
        deliveryDateLabel.text = "It will be delivered on" + afterNDays(7)
        collectionView.register(ShippingOptionCell.self, forCellWithReuseIdentifier: "ShippingOptionCell")
        
        let firstItemPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstItemPath, animated: false, scrollPosition: .left)
        
        NSLayoutConstraint.activate([
            shippingView.heightAnchor.constraint(equalToConstant: 150),
            
            shippingStackView.topAnchor.constraint(equalTo: shippingView.topAnchor),
            shippingStackView.leadingAnchor.constraint(equalTo: shippingView.leadingAnchor, constant: 0),
            shippingStackView.widthAnchor.constraint(equalTo: shippingView.widthAnchor),
            shippingStackView.heightAnchor.constraint(equalToConstant: 145),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.heightAnchor.constraint(equalToConstant: 70),
            collectionView.leadingAnchor.constraint(equalTo: shippingStackView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: shippingStackView.trailingAnchor),
            
            deliveryDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        return shippingView
    }
    
    private func createPaymentMethodView() -> UIView {
        let paymentMethodView: UIView = {
            let element = UIView()
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let titleLabel: UILabel = {
            let element = UILabel()
            element.text = "Payment Method"
            element.textAlignment = .left
            element.font = UIFont.boldSystemFont(ofSize: 20)
            element.textColor = .black
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        let editPaymentMethodButton: RoundButton = {
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
        
        let editCardButton: UIButton = {
            let element = UIButton()
            element.setTitle("Card", for: .normal)
            element.layer.cornerRadius = 20
            element.setTitleColor(#colorLiteral(red: 0, green: 0.2762006819, blue: 1, alpha: 1), for: .normal)
            element.backgroundColor = #colorLiteral(red: 0.8971917033, green: 0.9204418063, blue: 0.9870311618, alpha: 1)
            element.tintColor = .white
            element.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
        
        paymentMethodView.addSubview(titleLabel)
        paymentMethodView.addSubview(editPaymentMethodButton)
        paymentMethodView.addSubview(editCardButton)
        
        NSLayoutConstraint.activate([
            paymentMethodView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: paymentMethodView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: paymentMethodView.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: paymentMethodView.widthAnchor, multiplier: 0.1),
            titleLabel.widthAnchor.constraint(equalTo: paymentMethodView.widthAnchor, multiplier: 0.5),
            
            editPaymentMethodButton.trailingAnchor.constraint(equalTo: paymentMethodView.trailingAnchor, constant: -10),
            editPaymentMethodButton.topAnchor.constraint(equalTo: paymentMethodView.topAnchor),
            editPaymentMethodButton.widthAnchor.constraint(equalTo: paymentMethodView.widthAnchor, multiplier: 0.08),
            editPaymentMethodButton.heightAnchor.constraint(equalTo: paymentMethodView.widthAnchor, multiplier: 0.08),
            
            editCardButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            editCardButton.leadingAnchor.constraint(equalTo: paymentMethodView.leadingAnchor),
            editCardButton.heightAnchor.constraint(equalToConstant: 35),
            editCardButton.widthAnchor.constraint(equalTo: paymentMethodView.widthAnchor, multiplier: 0.2),
            
        ])
        
        return paymentMethodView
    }
    
    func updateTotalAmountLabel() {
        amountLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    func createTotalView() -> UIView {
        bottomView.addSubview(totalLabel)
        bottomView.addSubview(amountLabel)
        bottomView.addSubview(payButton)
        
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            totalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            totalLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 10),
            amountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            payButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            payButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            payButton.widthAnchor.constraint(equalToConstant: 120),
            payButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        return bottomView
    }
    
    // MARK: - Actions
    
    @objc func payButtonTapped() {
        // Создаем кастомный UIAlertController
        let customAlert = CustomAlertViewController()
        customAlert.modalPresentationStyle = .overCurrentContext  //прозрачный фон
        customAlert.modalTransitionStyle = .crossDissolve   //плавное появление
        
        //показываем кастомный Alert
        present(customAlert, animated: true, completion: nil)
    }
    
    // MARK: - Set delegates
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PaymentCell.self, forCellReuseIdentifier: "PaymentCell")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
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

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as? PaymentCell else {
            return UITableViewCell()
        }
        let item = cartItems[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75   //высота ячейки
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PaymentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shippingOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShippingOptionCell", for: indexPath) as? ShippingOptionCell else {
            return UICollectionViewCell()
        }
        let option = shippingOptions[indexPath.item]
        cell.configure(with: option)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Обработка выбора способа доставки
        print("Selected option: \(shippingOptions[indexPath.item].name) \(indexPath.item)")
        print("Итог: \(self.totalAmount)")
        
        let selectedOption = shippingOptions[indexPath.item]
            
            if selectedOption.name == "Express" {
                totalAmount += 12.00
            } else {
                totalAmount -= 12.00
            }
            
            updateTotalAmountLabel()
        
        if indexPath.item == 0 {
            deliveryDateLabel.text = "It will be delivered on " + afterNDays(7)
        } else {
            deliveryDateLabel.text = "It will be delivered on " + afterNDays(2)
            
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Ширина ячейки равна ширине UICollectionView минус отступы
        let width = collectionView.frame.width //- 10
        // Высота ячейки
        let height: CGFloat = 35
        return CGSize(width: width, height: height)
    }
}

private func afterNDays(_ countDays: Int) -> String {
    let currentDate = Date()    //получаем текущую дату
    let calendar = Calendar.current //создаем коалендарь
    
    //прибавляем 7 дней к текущей дате
    let futureDate = calendar.date(byAdding: .day, value: countDays, to: currentDate)
    let dateFormatter = DateFormatter() //создаем DateFormatter для форматирования даты в стркоу
    dateFormatter.dateFormat = "EEEE, MMMM, d, yyyy"
    let dateString = dateFormatter.string(from: futureDate ?? currentDate) //преобразуем дату в строку
    
    return dateString
}

