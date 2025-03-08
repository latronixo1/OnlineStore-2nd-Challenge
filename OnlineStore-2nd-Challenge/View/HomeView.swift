//
//  HomeView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeView: UIView {
    
    lazy var basketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .systemGray6
        searchBar.searchTextField.placeholder = "Search"
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    lazy var stackForSearchBarView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var layOutForCategory: UICollectionViewFlowLayout = {
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .vertical
        layOut.minimumLineSpacing = 8
        layOut.minimumInteritemSpacing = 8
        return layOut
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layOutForCategory)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var layOutForPopular: UICollectionViewFlowLayout = {
        let layOut = UICollectionViewFlowLayout()
        layOut.scrollDirection = .horizontal
        layOut.minimumLineSpacing = 8
        layOut.minimumInteritemSpacing = 8
        return layOut
    }()
    
    lazy var popularCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layOutForPopular)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var stackForCollectionView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var stackForAllView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        popularCollectionView.register(HomePopularCell.self, forCellWithReuseIdentifier: HomePopularCell.reuseIdentifier)
        addSubview(basketButton)
        stackForSearchBarView.addArrangedSubview(shopLabel)
        stackForSearchBarView.addArrangedSubview(searchBar)
        stackForCollectionView.addArrangedSubview(categoryCollectionView)
        stackForCollectionView.addArrangedSubview(popularCollectionView)
        stackForAllView.addArrangedSubview(stackForSearchBarView)
        stackForAllView.addArrangedSubview(stackForCollectionView)
        addSubview(stackForAllView)
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            // Bascet Button
            basketButton.topAnchor.constraint(equalTo: topAnchor),
            basketButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            basketButton.widthAnchor.constraint(equalToConstant: 40),
            basketButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Stack View
            stackForAllView.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 8),
            stackForAllView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackForAllView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackForAllView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: stackForCollectionView.topAnchor, constant: 8),
            categoryCollectionView.leftAnchor.constraint(equalTo: stackForCollectionView.leftAnchor),
            categoryCollectionView.rightAnchor.constraint(equalTo: stackForCollectionView.rightAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            // Popular Collection View
            popularCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
            popularCollectionView.leftAnchor.constraint(equalTo: stackForCollectionView.leftAnchor),
            popularCollectionView.rightAnchor.constraint(equalTo: stackForCollectionView.rightAnchor),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 203),
        ])
    }
}
