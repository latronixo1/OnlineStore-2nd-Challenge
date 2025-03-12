//
//  ShippingOptionCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 12.03.2025.
//

import UIKit

class ShippingOptionCell: UICollectionViewCell {
    static let reuseIdentifier = "ShippingOptionCell"
    
    let selectedImage: RoundImageView = {
        let imageView = RoundImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //настройка белой рамки
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "iconSelected")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let notSelectedImage: RoundImageView = {
        let imageView = RoundImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //настройка белой рамки
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372548461, blue: 0.9372549057, alpha: 1)
        imageView.isHidden = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        element.textColor = .black
        element.text = "nameLabel"
        element.textAlignment = .center
        element.numberOfLines = 0
        element.backgroundColor = .cyan
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "priceLabel"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.text = "durationLabel"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private let selectionIndicator: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBlue
//        view.layer.cornerRadius = 4
//        view.isHidden = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedImage.isHidden = false
                contentView.backgroundColor = #colorLiteral(red: 0.8971917033, green: 0.9204418063, blue: 0.9870311618, alpha: 1)
            } else {
                selectedImage.isHidden = true
                contentView.backgroundColor = #colorLiteral(red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
            }
            //layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.lightGray.cgColor
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        layer.cornerRadius = 10
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(notSelectedImage)
        contentView.addSubview(selectedImage)
        
        contentView.backgroundColor = #colorLiteral(red: 0.9800000787, green: 0.9800000787, blue: 0.9800000787, alpha: 1)
        
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(selectionIndicator)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            
            selectedImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectedImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            selectedImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            selectedImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            
            notSelectedImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            notSelectedImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            notSelectedImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            notSelectedImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            
//            selectedImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            selectedImage.widthAnchor.constraint(equalToConstant: 8),
//            selectedImage.heightAnchor.constraint(equalToConstant: 8),

//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            nameLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
//            //nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            nameLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
//            priceLabel.heightAnchor.constraint(equalToConstant: 15),
            
//            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
//            priceLabel.heightAnchor.constraint(equalToConstant: 15),
            
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with option: ShippingOption) {
        nameLabel.text = option.name
        durationLabel.text = option.duration
        priceLabel.text = option.price
    }
    
}
