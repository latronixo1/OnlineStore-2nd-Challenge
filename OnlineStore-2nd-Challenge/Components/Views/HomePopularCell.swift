//
//  HomePopularCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 06.03.2025.
//
import UIKit
class HomePopularCell: UICollectionViewCell {
    static let reuseIdentifier = "HomePopularCell"
    
    let photoOfProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let stackForLabelsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    let stackforelements: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray6
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // Labels
    let discriptionOfProduct: UILabel = {
        let label = UILabel()
        label.text = "category"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let priceOfProducts: UILabel = {
        let label = UILabel()
        label.text = "12345 products"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackForLabelsView.addArrangedSubview(discriptionOfProduct)
        stackForLabelsView.addArrangedSubview(priceOfProducts)
        
        stackforelements.addArrangedSubview(photoOfProduct)
        stackforelements.addArrangedSubview(stackForLabelsView)
        
        contentView.addSubview(stackforelements)
    }
    
    private func setupConstraints() {
        stackforelements.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackforelements.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackforelements.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackforelements.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackforelements.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            photoOfProduct.heightAnchor.constraint(equalToConstant: 130),

        ])
    }
}

