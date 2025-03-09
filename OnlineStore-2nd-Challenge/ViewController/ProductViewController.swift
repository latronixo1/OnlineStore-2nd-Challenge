//
//  ProductViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 02.03.2025.
//

import UIKit

final class ProductViewController: UIViewController {
    
    var product: Product
    var favoriteManager = FavoriteManager.shared
    
    private let priceLabel = UILabel.makeLabel(text: "17", font: UIFont.systemFont(ofSize: 26, weight: .bold), textColor: .black)
    private let descriptionLabel = UILabel.makeLabel(text: "descriptionLabel", font: UIFont.systemFont(ofSize: 15, weight: .regular), textColor: .black)
    private let variationsLabel = UILabel.makeLabel(text: "Variations", font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black)
    
    private let buttonLike = UIButton()
    private let buttonBuy = CustomButton(title: "Buy now", backgroundColor: .blue, textColor: .white, fontSize: .big)
    private let buttonAddCart = CustomButton(title: "Add to cart", backgroundColor: .black, textColor: .white, fontSize: .big)
    private let stackForButton = UIStackView()
    
    private let mainImage = UIImageView()
    private let imageVariations1 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let imageVariations2 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let imageVariations3 = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 75, widthAnchor: 75, border: false, shadow: false)
    private let stackForImage = UIStackView()
    
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
        [priceLabel, descriptionLabel, variationsLabel, buttonLike, buttonBuy, buttonAddCart, mainImage, imageVariations1, imageVariations2, imageVariations3, stackForImage, stackForButton].forEach { view.addSubview($0)
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
        stackForButton.addArrangedSubview(buttonAddCart)
        stackForButton.addArrangedSubview(buttonBuy)
        stackForButton.axis = .horizontal
        stackForButton.distribution = .fillEqually
        stackForButton.spacing = 16
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
            mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 18),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceLabel.heightAnchor.constraint(equalToConstant: 31),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            variationsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            variationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            variationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            variationsLabel.heightAnchor.constraint(equalToConstant: 26),
            
            stackForImage.topAnchor.constraint(equalTo: variationsLabel.bottomAnchor, constant: 12),
            stackForImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackForButton.topAnchor.constraint(equalTo: stackForImage.bottomAnchor, constant: 40),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
}
