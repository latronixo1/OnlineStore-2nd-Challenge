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
    
    private let shadowContainerForImageView: UIView = {
        let element = UIView()
        element.layer.shadowColor = UIColor.gray.cgColor
        element.layer.shadowOpacity = 0.8
        element.layer.shadowOffset = CGSize(width: 0, height: 5)
        element.layer.shadowRadius = 5.0
        element.layer.masksToBounds = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let productImageView: RoundImageView = {
        let imageView = RoundImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //настройка белой рамки
        imageView.layer.borderWidth = 5.0
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let quantityLabel: RoundLabel = {
        let label = RoundLabel()
        label.backgroundColor = UIColor(red: 229/255, green: 235/255, blue: 252/255, alpha: 1.0)
        //label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "1"
        //настройка белой рамки
        label.layer.borderWidth = 3.0
        label.layer.borderColor = UIColor.white.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
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
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$17,00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(shadowContainerForImageView)
        shadowContainerForImageView.addSubview(productImageView)
        shadowContainerForImageView.addSubview(quantityLabel)
        //shadowContainerForQuantityInCell.addSubview(quantityLabel)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 30),
            
            contentView.heightAnchor.constraint(equalToConstant: 30),
            
            shadowContainerForImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowContainerForImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            shadowContainerForImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            shadowContainerForImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
            productImageView.topAnchor.constraint(equalTo: shadowContainerForImageView.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: shadowContainerForImageView.leadingAnchor, constant: 5),
            productImageView.trailingAnchor.constraint(equalTo: shadowContainerForImageView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: shadowContainerForImageView.bottomAnchor),

            quantityLabel.topAnchor.constraint(equalTo: shadowContainerForImageView.topAnchor, constant: 10),
            quantityLabel.trailingAnchor.constraint(equalTo: shadowContainerForImageView.trailingAnchor),
            quantityLabel.widthAnchor.constraint(equalTo: shadowContainerForImageView.widthAnchor, multiplier: 0.4),
            quantityLabel.heightAnchor.constraint(equalTo: shadowContainerForImageView.widthAnchor, multiplier: 0.4),

            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
        ])
    }
    
     func configure(with item: CartItem) {
        productImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        priceLabel.text = item.price
        quantityLabel.text = String(item.quantity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//следующий код необходим, чтобы сделать картинку круглой, если мы не знаем ее размеров
class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2.0
        layer.masksToBounds = true  //обрезаем содержимое по границам
    }
}
