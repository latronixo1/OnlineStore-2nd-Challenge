//
//  CartViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by vp.off on 04.03.2025.
//

import UIKit

final class CartViewController: UIViewController {
    
    private var cartItems: [Product] = FavoriteManager.shared.loadCartProducts()
//    var cartItems: [CartItem] = [
//        CartItem(imageName: "blousePink", title: "Fitted cotton blouse with short sleeves and high waist", price: "$17,00", quantity: 2),
//        CartItem(imageName: "dressRed", title: "Strapless Satin Evening Dress with Full Skirt", price: "$25,00", quantity: 1)
//    ]
    private let favoriteManager = FavoriteManager.shared
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 229/255, green: 235/255, blue: 252/255, alpha: 1.0)
        label.text = "2"
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mockaddress"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "$34,00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupUI()
        
        DispatchQueue.main.async {
            self.reloadCartProducts()
            self.tableView.reloadData()
        }
    }
    
    func reloadCartProducts() {
        cartItems = favoriteManager.cartArray
        print("добавленные товары \(cartItems.count)")
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(badgeLabel)
        view.addSubview(addressImageView)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(totalLabel)
        bottomView.addSubview(amountLabel)
        bottomView.addSubview(checkoutButton)
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 7),
            badgeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            badgeLabel.widthAnchor.constraint(equalToConstant: 30),
            badgeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            addressImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            addressImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addressImageView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: addressImageView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10),

            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            
            totalLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            totalLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor, constant: 10),
            amountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            checkoutButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            checkoutButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            checkoutButton.widthAnchor.constraint(equalToConstant: 120),
            checkoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func checkoutButtonTapped() {
//        let paymentVC = PaymentViewController(cartItems)
//        self.navigationController?.pushViewController(paymentVC, animated: true)
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let item = cartItems[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    
    func didTapIncreaseButton(on cell: CartCell) {
        print("Increase button tapped")
    }

    func didTapDecreaseButton(on cell: CartCell) {
        print("Decrease button tapped")
    }

    func didTapDeleteButton(on cell: CartCell) {
        print("Delete button tapped")
    }
}

