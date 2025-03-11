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
        button.setImage(UIImage(named: "cart"), for: .normal)
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .highlighted)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    lazy var notificationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 7)
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 6
        lbl.layer.masksToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: SEARCH_STACK
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
    //MARK: CATEGORY
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
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var categoryButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "See All"
        configuration.image = UIImage(named: "chevronButton")
        configuration.imagePadding = 8
        configuration.baseForegroundColor = .black
        configuration.imagePlacement = .trailing
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackForLabelCategory: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var stackForCategoryView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: POPULAR
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
    lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var popularButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "See All"
        configuration.image = UIImage(named: "chevronButton")
        configuration.imagePadding = 8
        configuration.baseForegroundColor = .black
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackForLabelPopular: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var stackForPopularView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: STACKForCollectionView
    lazy var stackForCollectionView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: stackForAllView
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
        basketButton.addSubview(notificationLabel)
        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        popularCollectionView.register(HomePopularCell.self, forCellWithReuseIdentifier: HomePopularCell.reuseIdentifier)
        addSubview(basketButton)
        stackForSearchBarView.addArrangedSubview(shopLabel)
        stackForSearchBarView.addArrangedSubview(searchBar)
        
        stackForLabelCategory.addArrangedSubview(categoryLabel)
        stackForLabelCategory.addArrangedSubview(categoryButton)
        stackForCategoryView.addArrangedSubview(stackForLabelCategory)
        stackForCategoryView.addArrangedSubview(categoryCollectionView)
        
        stackForLabelPopular.addArrangedSubview(popularLabel)
        stackForLabelPopular.addArrangedSubview(popularButton)
        stackForPopularView.addArrangedSubview(stackForLabelPopular)
        stackForPopularView.addArrangedSubview(popularCollectionView)
        
        stackForCollectionView.addArrangedSubview(stackForCategoryView)
        stackForCollectionView.addArrangedSubview(stackForPopularView)
        
        stackForAllView.addArrangedSubview(stackForSearchBarView)
        stackForAllView.addArrangedSubview(stackForCollectionView)
        addSubview(stackForAllView)
    }
    func setConstraint() {
        NSLayoutConstraint.activate([
            // Basket Button
            basketButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            basketButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            basketButton.widthAnchor.constraint(equalToConstant: 40),
            basketButton.heightAnchor.constraint(equalToConstant: 40),
            
            notificationLabel.widthAnchor.constraint(equalToConstant: 12),
            notificationLabel.heightAnchor.constraint(equalToConstant: 12),
            notificationLabel.centerXAnchor.constraint(equalTo: basketButton.centerXAnchor, constant: 9),
            notificationLabel.centerYAnchor.constraint(equalTo: basketButton.centerYAnchor, constant: -9),
            
            // Stack For All View
            stackForAllView.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 8),
            stackForAllView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackForAllView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackForAllView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            // Stack For Category View
            stackForCategoryView.topAnchor.constraint(equalTo: stackForAllView.topAnchor),
            stackForCategoryView.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor),
            stackForCategoryView.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor),
            stackForCategoryView.heightAnchor.constraint(equalToConstant: 300),
            
            // Stack For Label Category
            stackForLabelCategory.topAnchor.constraint(equalTo: stackForCategoryView.topAnchor),
            stackForLabelCategory.leftAnchor.constraint(equalTo: stackForCategoryView.leftAnchor, constant: 10),
            stackForLabelCategory.rightAnchor.constraint(equalTo: stackForCategoryView.rightAnchor, constant: -10),
            stackForLabelCategory.heightAnchor.constraint(equalToConstant: 30),
            
            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: stackForLabelCategory.bottomAnchor, constant: 8),
            categoryCollectionView.leftAnchor.constraint(equalTo: stackForCategoryView.leftAnchor),
            categoryCollectionView.rightAnchor.constraint(equalTo: stackForCategoryView.rightAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: stackForCategoryView.bottomAnchor),
            
            // Stack For Popular View
            stackForPopularView.topAnchor.constraint(equalTo: stackForCategoryView.bottomAnchor),
            stackForPopularView.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor),
            stackForPopularView.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor),
            stackForPopularView.heightAnchor.constraint(equalToConstant: 250),
            
            // Stack For Label Popular
            stackForLabelPopular.topAnchor.constraint(equalTo: stackForPopularView.topAnchor, constant: 5),
            stackForLabelPopular.leftAnchor.constraint(equalTo: stackForPopularView.leftAnchor, constant: 10),
            stackForLabelPopular.rightAnchor.constraint(equalTo: stackForPopularView.rightAnchor, constant: -10),
            stackForLabelPopular.heightAnchor.constraint(equalTo: stackForPopularView.heightAnchor, multiplier: 0.15),
            
            // Popular Collection View
            popularCollectionView.topAnchor.constraint(equalTo: stackForLabelPopular.bottomAnchor, constant: 8),
            popularCollectionView.leftAnchor.constraint(equalTo: stackForPopularView.leftAnchor),
            popularCollectionView.rightAnchor.constraint(equalTo: stackForPopularView.rightAnchor),
            popularCollectionView.heightAnchor.constraint(equalTo: stackForPopularView.heightAnchor, multiplier: 0.85),
        ])
    }
}


    
//    func setConstraint() {
        
//        NSLayoutConstraint.activate([
//            // Bascet Button
//            basketButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
//            basketButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            basketButton.widthAnchor.constraint(equalToConstant: 40),
//            basketButton.heightAnchor.constraint(equalToConstant: 40),
//            
//            // Stack View
//            stackForAllView.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 8),
//            stackForAllView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            stackForAllView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            stackForAllView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            
//            stackForCategoryView.topAnchor.constraint(equalTo: stackForAllView.topAnchor),
//            stackForCategoryView.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor),
//            stackForCategoryView.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor),
//            stackForCategoryView.heightAnchor.constraint(equalToConstant: 500),
//            
//            stackForLabelCategory.topAnchor.constraint(equalTo: stackForAllView.topAnchor),
//            stackForLabelCategory.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor, constant: 10),
//            stackForLabelCategory.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor, constant: -10),
//            stackForLabelCategory.heightAnchor.constraint(equalToConstant: 30),
//            
//            // Category Collection View
//            categoryCollectionView.topAnchor.constraint(equalTo: stackForLabelCategory.bottomAnchor, constant: 8),
//            categoryCollectionView.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor),
//            categoryCollectionView.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor),
//            categoryCollectionView.heightAnchor.constraint(equalToConstant: 430),
//            
//            stackForPopularView.topAnchor.constraint(equalTo: stackForCategoryView.bottomAnchor, constant: 10),
//            stackForPopularView.leftAnchor.constraint(equalTo: stackForAllView.leftAnchor),
//            stackForPopularView.rightAnchor.constraint(equalTo: stackForAllView.rightAnchor),
//            stackForPopularView.heightAnchor.constraint(equalToConstant: 270),
//            
//            stackForLabelPopular.topAnchor.constraint(equalTo: stackForPopularView.topAnchor),
//            stackForLabelPopular.leftAnchor.constraint(equalTo: stackForPopularView.leftAnchor, constant: 10),
//            stackForLabelPopular.rightAnchor.constraint(equalTo: stackForPopularView.rightAnchor, constant: -10),
//            stackForLabelPopular.heightAnchor.constraint(equalToConstant: 30),
//            // Popular Collection View
//            popularCollectionView.topAnchor.constraint(equalTo: stackForLabelPopular.bottomAnchor, constant: 8),
//            popularCollectionView.leftAnchor.constraint(equalTo: stackForPopularView.leftAnchor),
//            popularCollectionView.rightAnchor.constraint(equalTo: stackForPopularView.rightAnchor),
//            popularCollectionView.heightAnchor.constraint(equalToConstant: 230),
//        ])
//    }

