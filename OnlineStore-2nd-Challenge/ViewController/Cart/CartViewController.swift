import UIKit

final class CartViewController: UIViewController {
    
    
    private var cartItems: [Product] = SaveToCartManager.shared.loadCartProducts()
    //    var cartItems: [CartItem] = [
    //        CartItem(imageName: "blousePink", title: "Fitted cotton blouse with short sleeves and high waist", price: "$17,00", quantity: 2),
    //        CartItem(imageName: "dressRed", title: "Strapless Satin Evening Dress with Full Skirt", price: "$25,00", quantity: 1)
    //    ]
    
    private let saveToCartManager = SaveToCartManager.shared
    var sum = 0.00
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let badgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 229/255, green: 235/255, blue: 252/255, alpha: 1.0)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var badgeQuantity: Int = 1 {
        didSet {
            badgeLabel.text = "\(cartItems.count)"
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
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
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "$%.2f"
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
    
    private lazy var cartIsEmpty: UILabel = {
        let element = UILabel()
        element.text = "There's nothing here yet"
        element.font = UIFont.systemFont(ofSize: 30)
        element.textColor = .black
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupUI()
        
        DispatchQueue.main.async {
            self.reloadCartProducts()
            self.totalSum()
            self.updateTotalAmount()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCartProducts()
        //totalSum()
        updateTotalAmount()
        tableView.reloadData()
    }
    
    
    func reloadCartProducts() {
        cartItems = saveToCartManager.cartArray
        print("добавленные товары \(cartItems.count)")
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
    }
    
    func totalSum() {
        sum = Double(cartItems.reduce(0.00) { partialResult, nextValue in
            return partialResult + nextValue.price
        })
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(badgeLabel)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        view.addSubview(cartIsEmpty)
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
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -10),
            
            cartIsEmpty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartIsEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
        let paymentVC = PaymentViewController(cartItems, totalAmount: sum)
        navigationController?.pushViewController(paymentVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.configure(with: cartItems[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
}

extension CartViewController: CartCellDelegate {
    func didTapIncreaseButton(on cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = cartItems[indexPath.row]
        sum += product.price
        saveToCartManager.addToCart(product: product)
        updateTotalAmount()
    }
    
    func didTapDecreaseButton(on cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = cartItems[indexPath.row]
        sum -= product.price
        saveToCartManager.removeProductsFromCart(product: product)
        updateTotalAmount()
    }
    
    func didTapDeleteButton(on cell: CartCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = cartItems[indexPath.row]
        sum -= product.price * Double(cell.quantity)
        
        cartItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveToCartManager.removeProductsFromCart(product: product)
        updateTotalAmount()
    }
    
    private func updateTotalAmount() {
        totalSum()
        if sum == 0.00 {
            cartIsEmpty.isHidden = false
            checkoutButton.isEnabled = false
            checkoutButton.backgroundColor = #colorLiteral(red: 0.8235358596, green: 0.8059974909, blue: 0.7952066064, alpha: 1)
        } else {
            cartIsEmpty.isHidden = true
            checkoutButton.isEnabled = true
            checkoutButton.backgroundColor = .blue
        }
        amountLabel.text = String(format: "$%.2f", sum)
        badgeLabel.text = "\(cartItems.count)"
    }
    
}
