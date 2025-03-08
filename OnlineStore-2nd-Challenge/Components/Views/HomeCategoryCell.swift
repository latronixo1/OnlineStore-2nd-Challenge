//
//  HomeCategoryCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//
import UIKit

class HomeCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCategoryCell"
    
    let firstImageView = UIImageView()
    let secondImageView = UIImageView()
    let thirdImageView = UIImageView()
    let fourthImageView = UIImageView()
    
    let firstImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    
    let secondStackFOrImage: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    let thirdStackFOrImage: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    
    let stackOfCategory: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
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
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        firstImageStackView.addArrangedSubview(firstImageView)
        firstImageStackView.addArrangedSubview(secondImageView)
        
        secondStackFOrImage.addArrangedSubview(thirdImageView)
        secondStackFOrImage.addArrangedSubview(fourthImageView)
        
        thirdStackFOrImage.addArrangedSubview(secondStackFOrImage)
        thirdStackFOrImage.addArrangedSubview(firstImageStackView)
        
        stackOfCategory.addArrangedSubview(labelOfCategory)
        stackOfCategory.addArrangedSubview(quantityOfProducts)
        
        stackforelements.addArrangedSubview(thirdStackFOrImage)
        stackforelements.addArrangedSubview(stackOfCategory)
        
        contentView.addSubview(stackforelements)
    }
    
    private func setupConstraints() {
        stackforelements.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackforelements.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackforelements.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackforelements.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackforelements.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackOfCategory.leftAnchor.constraint(equalTo: stackforelements.leftAnchor, constant: 8),
            stackOfCategory.rightAnchor.constraint(equalTo: stackforelements.rightAnchor, constant: -8),
        ])
    }
    
    private func configureImageViews() {
        let imageViews = [firstImageView, secondImageView, thirdImageView, fourthImageView]
        for imageView in imageViews {
            imageView.image = UIImage(systemName: "plus")
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = .black
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        }
    }
    private func setupShadow() {
        // Настройка тени
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3 // Прозрачность тени
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени
        contentView.layer.shadowRadius = 4 // Радиус размытия тени
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 8
        contentView.layer.backgroundColor = UIColor.white.cgColor // Фон для contentView
    }
}
