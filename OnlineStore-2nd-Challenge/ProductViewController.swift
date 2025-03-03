//
//  ProductViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 02.03.2025.
//

import UIKit

final class ProductViewController: UIViewController {
    
    private let priceLabel = UILabel.makeLabel(font: UIFont.systemFont(ofSize: 26, weight: .bold), textColor: .black)
    private let descriptionLabel = UILabel.makeLabel(font: UIFont.systemFont(ofSize: 15, weight: .regular), textColor: .black)
    private let variationsLabel = UILabel.makeLabel(font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black)
    
    private let buttonLike = UIButton()
    private let buttonBuy = UIButton.makeButton(text: "Buy now", font: UIFont.systemFont(ofSize: 16, weight: .light), textColor: .white, cornerRadius: 16, colorBackground: .blue)
    private let buttonAddCart = UIButton.makeButton(text: "Add to cart", font: UIFont.systemFont(ofSize: 16, weight: .light), textColor: .white, cornerRadius: 16, colorBackground: .black)
    private let stackForButton = UIStackView()
    
    private let mainImage = UIImageView()
    private let imageVariations1 = UIImageView.makeImage(cornerRadius: 4, heightAnchor: 75, widthAnchor: 75)
    private let imageVariations2 = UIImageView.makeImage(cornerRadius: 4, heightAnchor: 75, widthAnchor: 75)
    private let imageVariations3 = UIImageView.makeImage(cornerRadius: 4, heightAnchor: 75, widthAnchor: 75)
    private let stackForImage = UIStackView()
    
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
        mainImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        mainImage.layer.masksToBounds = true
        mainImage.contentMode = .scaleAspectFill
        mainImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackForButton() {
        stackForButton.addArrangedSubview(buttonBuy)
        stackForButton.addArrangedSubview(buttonLike)
        stackForButton.axis = .horizontal
        stackForButton.spacing = 4
        stackForButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStackForImage() {
        stackForImage.addArrangedSubview(imageVariations1)
        stackForImage.addArrangedSubview(imageVariations2)
        stackForImage.addArrangedSubview(imageVariations3)
        stackForImage.axis = .horizontal
        stackForImage.spacing = 4
        stackForImage.translatesAutoresizingMaskIntoConstraints = false
    }
}


private extension ProductViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
