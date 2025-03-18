//
//  ProductViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 02.03.2025.
//

import UIKit

final class ProductViewController: UIViewController {
    
    var product: Product
    var saveToCartManager = SaveToCartManager.shared
    var favoriteManager = FavoriteManager.shared
    
    private let priceLabel = UILabel.makeLabel(text: "17", font: UIFont.systemFont(ofSize: 26, weight: .bold), textColor: .black, numberOfLines: 1)
    private let descriptionLabel = UILabel.makeLabel(text: "descriptionLabel", font: UIFont.systemFont(ofSize: 15, weight: .regular), textColor: .black, numberOfLines: 2)
    private let variationsLabel = UILabel.makeLabel(text: "Variations", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black, numberOfLines: 1)
    
    private let buttonLike = UIButton()
    var isSelect: Bool = true
    private let buttonBuy = CustomButton(title: "Buy now", backgroundColor: .blue, textColor: .white, fontSize: .big)
    private let buttonAddCart = CustomButton(title: "Add to cart", backgroundColor: .black, textColor: .white, fontSize: .big)
    private let stackForButton = UIStackView()
    
    private let mainImage = UIImageView()
    private let imageVariations1 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let imageVariations2 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let imageVariations3 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let stackForImage = UIStackView()
    var currentProduct: Product?
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        addTarget()
        setupNavBar()
        priceLabel.text = "$" + product.price.formatted()
        descriptionLabel.text = product.description
        currentProduct = product
        
        isSelect = favoriteManager.isFavorite(product: currentProduct ?? product)
        buttonLike.setImage(UIImage(resource: isSelect ? .heartFill : .heart), for: .normal)
        
        if let imageURL = URL(string: product.image) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mainImage.image = image
                        self.imageVariations1.image = image
                        self.imageVariations2.image = image
                        self.imageVariations3.image = image
                    }
                }
            }.resume()
        }
        
    }
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(tapBackButton))
    }
    
    @objc func tapBackButton() {
        print("back button tap")
        navigationController?.popToRootViewController(animated: true)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
    
    private func addTarget() {
        buttonBuy.addTarget(self, action: #selector(tapBuyNow(_:)), for: .touchUpInside)
        buttonAddCart.addTarget(self, action: #selector(tapAddCard(_:)), for: .touchUpInside)
        buttonLike.addTarget(self, action: #selector(tapButtonLike), for: .touchUpInside)
    }
    
    @objc func tapBuyNow(_ sender: UIButton) {
         // Анимация для кнопки
         animateButton(sender)
         
         guard let product = currentProduct else {return}

         let paymentVC = PaymentViewController(Array(arrayLiteral: product), totalAmount: product.price)
         navigationController?.pushViewController(paymentVC, animated: true)

         saveToCartManager.addToCart(product: product)
         print("button Buy now tapped")
     }

    @objc func tapAddCard(_ sender: UIButton) {
        // Анимация для кнопки
        animateButton(sender)

        saveToCartManager.addToCart(product: product)
        print("product add to cart")
    }
    
    @objc func tapButtonLike() {
        guard let product = currentProduct else {return}
        if isSelect {
            buttonLike.setImage(UIImage(resource: .heart), for: .normal)
            favoriteManager.removeFromFavorite(product: product)
        } else {
            buttonLike.setImage(UIImage(resource: .heartFill), for: .normal)
            favoriteManager.addToFavorite(product: product)
        }
        isSelect.toggle()
        print("Like tapped")
    }
    
    private func animateButton(_ button: UIButton) {
        // Анимация уменьшения масштаба
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            // Возвращаем кнопку к исходному размеру
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        }
    }

    
}


private extension ProductViewController {
    func setup() {
        addSubviews()
        setupMainImage()
        setupStackForImage()
        setupStackForButton()
        setupLayout()
    }
    
    func addSubviews() {
        [priceLabel, descriptionLabel, variationsLabel, buttonLike, buttonBuy, buttonAddCart, mainImage, imageVariations1, imageVariations2, imageVariations3, stackForImage, stackForButton, buttonLike].forEach { view.addSubview($0)
        }
    }
    
    func setupMainImage() {
        mainImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
        mainImage.image = UIImage(named: "Image")
        mainImage.layer.masksToBounds = true
        mainImage.contentMode = .scaleAspectFill
        mainImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackForButton() {
        buttonLike.translatesAutoresizingMaskIntoConstraints = false
        buttonLike.widthAnchor.constraint(equalToConstant: 24).isActive = true
        buttonLike.heightAnchor.constraint(equalToConstant: 24).isActive = true
        stackForButton.addArrangedSubview(buttonLike)
        stackForButton.addArrangedSubview(buttonAddCart)
        stackForButton.addArrangedSubview(buttonBuy)
        stackForButton.axis = .horizontal
        stackForButton.distribution = .fillProportionally
        stackForButton.spacing = 8
        stackForButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackForImage() {
        stackForImage.addArrangedSubview(imageVariations1)
        stackForImage.addArrangedSubview(imageVariations2)
        stackForImage.addArrangedSubview(imageVariations3)
        stackForImage.axis = .horizontal
        stackForImage.spacing = 6
        stackForImage.translatesAutoresizingMaskIntoConstraints = false
    }
}


private extension ProductViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 18),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceLabel.heightAnchor.constraint(equalToConstant: 31),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            variationsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            variationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            variationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            variationsLabel.heightAnchor.constraint(equalToConstant: 26),
            
            stackForImage.topAnchor.constraint(equalTo: variationsLabel.bottomAnchor, constant: 4),
            stackForImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackForButton.heightAnchor.constraint(equalToConstant: 40),
            stackForButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
}
