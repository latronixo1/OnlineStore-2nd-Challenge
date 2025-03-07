//
//  HomeCategoryCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//
import UIKit

class HomeCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCategoryCell"
    
    // ImageView's
    let firstImageView = UIImageView()
    let secondImageView = UIImageView()
    let thirdImageView = UIImageView()
    let fourthImageView = UIImageView()
    
    // Stack Views
    let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    let secondStackFOrImage: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    let stackOfCategory: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    let stackforelements: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    // Labels
    let labelOfCategory: UILabel = {
        let label = UILabel()
        label.text = "category"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let quantityOfProducts: UILabel = {
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
        configureImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageStackView.addArrangedSubview(firstImageView)
        imageStackView.addArrangedSubview(secondImageView)
        
        secondStackFOrImage.addArrangedSubview(thirdImageView)
        secondStackFOrImage.addArrangedSubview(fourthImageView)
        
        stackOfCategory.addArrangedSubview(labelOfCategory)
        stackOfCategory.addArrangedSubview(quantityOfProducts)
        
        stackforelements.addArrangedSubview(imageStackView)
        stackforelements.addArrangedSubview(secondStackFOrImage)
        stackforelements.addArrangedSubview(stackOfCategory)
        
        contentView.addSubview(stackforelements)
    }
    
    private func setupConstraints() {
        stackforelements.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackforelements.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackforelements.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackforelements.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackforelements.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureImageViews() {
        let imageViews = [firstImageView, secondImageView, thirdImageView, fourthImageView]
        for imageView in imageViews {
            imageView.image = UIImage(systemName: "plus")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.tintColor = .black
            imageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
