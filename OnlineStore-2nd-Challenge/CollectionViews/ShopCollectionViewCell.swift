//
//  ShopCollectionViewCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 04.03.2025.
//

import UIKit

final class ShopCollectionViewCell: UICollectionViewCell {
    //MARK: - Private Property
    private let viewBg = UIView()
    private let imageView = UIImageView.makeImage(named: "Image", cornerRadius: 4, heightAnchor: 170, widthAnchor: 160)
    private let descriptionLabel = UILabel.makeLabel(text: "Lorem ipsum dolor sit amet consectetur", font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: .black)
    private let priceLabel = UILabel.makeLabel(text: "$17,00", font: UIFont.systemFont(ofSize: 17, weight: .bold), textColor: .black)
    private let buttonLike = UIButton()
    private let buttonBuy = CustomButton(title: "Add to cart", backgroundColor: .blue, textColor: .white, fontSize: .small)
    private let isSelect = Bool()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            buttonBuy.trailingAnchor.constraint(equalTo: viewBg.trailingAnchor),
            
        ])
    }
}
