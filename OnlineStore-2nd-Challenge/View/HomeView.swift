//
//  HomeView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeView: UIView {
    
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
        searchBar.searchTextField.backgroundColor = .systemGray6
        searchBar.searchTextField.placeholder = "Search"
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView() {
        addSubview(bascetButton)
        stackView.addArrangedSubview(shopLabel)
        stackView.addArrangedSubview(searchBar)
        addSubview(stackView)
        addSubview(categoryCollectionView)
        addSubview(popularCollectionView)
        addSubview(justForYouCollectionView)
        
        bascetButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        justForYouCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            // Bascet Button
            bascetButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bascetButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            bascetButton.widthAnchor.constraint(equalToConstant: 40),
            bascetButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Stack View
            stackView.topAnchor.constraint(equalTo: bascetButton.bottomAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            categoryCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            categoryCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalTo: categoryCollectionView.widthAnchor, multiplier: 0.5),
            
            // Popular Collection View
            popularCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
            popularCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            popularCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            // Just For You Collection View
            justForYouCollectionView.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 8),
            justForYouCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            justForYouCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            justForYouCollectionView.heightAnchor.constraint(equalTo: justForYouCollectionView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func createTwoInARowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        let totalSpacing = layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right
        let width = (UIScreen.main.bounds.width - totalSpacing - 40) / 2
        let height = width * 1.2
        layout.itemSize = CGSize(width: width, height: height)
        
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
