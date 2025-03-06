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
    lazy var bascetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .black
        return button
    }()

    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.textColor = .black
        return label
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .systemGray6
        searchBar.layer.cornerRadius = 8
        return searchBar
    }()

    lazy var categoryCollectionView: UICollectionView = {
        let layout = createTwoInARowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var justForYouCollectionView: UICollectionView = {
        let layout = createTwoInARowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var stakeView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    // Обязательный инициализатор для программного создания ячейки
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
    }

    // Обязательный инициализатор для создания ячейки из Storyboard/XIB
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Настройка UI
    private func setView() {
        addSubview(bascetButton)
        stakeView.addArrangedSubview(shopLabel)
        stakeView.addArrangedSubview(searchBar)
        addSubview(stakeView)
        addSubview(categoryCollectionView)
        addSubview(popularCollectionView)
        addSubview(justForYouCollectionView)

        bascetButton.translatesAutoresizingMaskIntoConstraints = false
        stakeView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        justForYouCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    // Настройка констрейнтов
    private func setConstraint() {
        NSLayoutConstraint.activate([
            // Bascet Button
            bascetButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bascetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            // Stake View
            stakeView.topAnchor.constraint(equalTo: bascetButton.bottomAnchor, constant: 8),
            stakeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stakeView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stakeView.heightAnchor.constraint(equalToConstant: 50),

            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: stakeView.bottomAnchor, constant: 8),
            categoryCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            categoryCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 300),

            // Popular Collection View
            popularCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
            popularCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            popularCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 200),

            // Just For You Collection View
            justForYouCollectionView.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 8),
            justForYouCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            justForYouCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            justForYouCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
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
