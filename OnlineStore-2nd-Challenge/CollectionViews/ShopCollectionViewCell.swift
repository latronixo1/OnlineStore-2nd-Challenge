//
//  ShopCollectionViewCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 04.03.2025.
//

import UIKit

final class ShopCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private Property
    static let identifier = "ShopCell"
    private let favoriteManager = FavoriteManager.shared
    
    private let viewBg = UIView()
    let imageView = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 170, widthAnchor: 160, border: false, shadow: false)
    private let descriptionLabel = UILabel.makeLabel(text: "Lorem ipsum dolor sit amet consectetur", font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: .black, numberOfLines: 2)
    private let priceLabel = UILabel.makeLabel(text: "$17,00", font: UIFont.systemFont(ofSize: 17, weight: .bold), textColor: .black, numberOfLines: 1)
    private let buttonLike = UIButton()
    private let buttonBuy = CustomButton(title: "Add to cart", backgroundColor: .blue, textColor: .white, fontSize: .small)
    var isSelect: Bool = true
    var currentProduct: Product?
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Product) {
        imageView.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
        priceLabel.text = model.price.formatted()
        currentProduct = model
        
        isSelect = favoriteManager.isFavorite(product: model)
        buttonLike.setImage(UIImage(resource: isSelect ? .heartFill : .heart), for: .normal)
        
        if let imageURL = URL(string: model.image) {
            NetworkService.shared.fetchImage(from: imageURL.absoluteString) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.imageView.image = image
                    case .failure(let error):
                        print("Ошибка загрузки изображения: \(error.localizedDescription)")
                        self.imageView.image = UIImage(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}



private extension ShopCollectionViewCell {
    func setupViews() {
        contentView.addSubview(viewBg)
        viewBg.addSubview(imageView)
        viewBg.addSubview(descriptionLabel)
        viewBg.addSubview(priceLabel)
        viewBg.addSubview(buttonBuy)
        viewBg.addSubview(buttonLike)
        
        viewBg.backgroundColor = .white
        setupLayout()
        setupButtonLike()
        setupButtonAddCard()
    }
    
    func setupButtonAddCard() {
        buttonBuy.addTarget(self, action: #selector(tapAddCard), for: .touchUpInside)
    }
    
    func setupButtonLike() {
        //buttonLike.setImage(UIImage(resource: .heartFill), for: .normal)
        buttonLike.widthAnchor.constraint(equalToConstant: 24).isActive = true
        buttonLike.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        buttonLike.addTarget(self, action: #selector(buttonLikeTapped), for: .touchUpInside)
    }
    
    @objc func tapAddCard() {
        guard let product = currentProduct else {return}
        favoriteManager.addToCart(product: product)
        print("product add to cart")
    }
    
    @objc func buttonLikeTapped() {
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
}


private extension ShopCollectionViewCell {
    func setupLayout() {
        [viewBg, imageView, descriptionLabel, priceLabel, buttonBuy, buttonLike].forEach { $0.translatesAutoresizingMaskIntoConstraints  = false}
        
        NSLayoutConstraint.activate([
            viewBg.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewBg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewBg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewBg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: viewBg.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewBg.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 11),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewBg.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1),
            priceLabel.leadingAnchor.constraint(equalTo: viewBg.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor),
            
            buttonBuy.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            buttonBuy.leadingAnchor.constraint(equalTo: viewBg.leadingAnchor),
            buttonBuy.widthAnchor.constraint(equalToConstant: 120),
            
            buttonLike.topAnchor.constraint(equalTo: buttonBuy.topAnchor),
            buttonLike.leadingAnchor.constraint(equalTo: buttonBuy.trailingAnchor, constant: 16),
            buttonLike.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor),
            
        ])
    }
}
