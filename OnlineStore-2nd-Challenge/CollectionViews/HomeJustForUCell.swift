//
//  JustCategoryCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 06.03.2025.
//

import UIKit

class HomeJustForUCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeJustForUCell"

    // UI элементы
    let photoofProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let priceOfProduct: UILabel = {
        let label = UILabel()
        return label
    }()
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        button.tintColor = .red
        return button
    }()
    
    let bascetButton: UIButton = {
        let button = UIButton()
        button.setTitle("add to cart", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .button
        return button
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setView() {
        addSubview(photoofProduct)
        stackView.addArrangedSubview(priceOfProduct)
        stackView.addArrangedSubview(heartButton)
        addSubview(stackView)
        addSubview(bascetButton)
    }

    private func setConstraint() {
        NSLayoutConstraint.activate([])
    }

    // Создание layout для коллекции
    private func createTwoInARowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return layout
    }
}
