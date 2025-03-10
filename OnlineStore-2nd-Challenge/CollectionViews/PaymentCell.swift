//
//  PaymentCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 10.03.2025.
//

import UIKit

protocol PaymentCellDelegate: AnyObject {
    func didTapIncreaseButton(on cell: PaymentCell)
    func didTapDecreaseButton(on cell: PaymentCell)
    func didTapDeleteButton(on cell: PaymentCell)
}

final class PaymentCell: UITableViewCell {
    
    weak var delegate: PaymentCellDelegate?
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LLorem ipsum dolor sit amet consectetur."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Pink, Size M"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$17,00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 15
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 15
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 229/255, green: 235/255, blue: 252/255, alpha: 1.0)
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var quantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(increaseButton)
        contentView.addSubview(decreaseButton)
        contentView.addSubview(deleteButton)
        contentView.addSubview(quantityLabel)
        
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 129),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            sizeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            sizeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            decreaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -97),
            decreaseButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            quantityLabel.leadingAnchor.constraint(equalTo: decreaseButton.trailingAnchor, constant: 6),
            quantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 37),
            quantityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            increaseButton.leadingAnchor.constraint(equalTo: decreaseButton.trailingAnchor, constant: 49),
            increaseButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func increaseButtonTapped() {
        quantity += 1
        delegate?.didTapIncreaseButton(on: self)
    }

    @objc private func decreaseButtonTapped() {
        if quantity > 1 {
            quantity -= 1
        }
        delegate?.didTapDecreaseButton(on: self)
    }

    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(on: self)
    }
    
    func configure(with item: CartItem) {
        productImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        priceLabel.text = item.price
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
