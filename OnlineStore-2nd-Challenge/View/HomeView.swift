//
//  HomeView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeView: UIView {
    
    //MARK: Bascket and Adress
//    lazy var basketAndAdressStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//        stackView.alignment = .trailing
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()

//    lazy var adress: UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "HomeViewAdress")
//        img.contentMode = .scaleAspectFit
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()

//    lazy var basketButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "cart"), for: .normal)
//        button.tintColor = .black
//        button.imageView?.contentMode = .scaleAspectFit
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = true
//
//        return button
//    }()
    
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
//    lazy var labelOfScreen: UILabel = {
//        let label = UILabel()
//        label.text = "Shop"
//        label.textAlignment = .left
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackForLabelAndSearchButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
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
        //basketButton.addSubview(notificationLabel)
        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        popularCollectionView.register(HomePopularCell.self, forCellWithReuseIdentifier: HomePopularCell.reuseIdentifier)
        
//        basketAndAdressStackView.addArrangedSubview(adress)
//        basketAndAdressStackView.addArrangedSubview(basketButton)
//        addSubview(basketAndAdressStackView)
        //addSubview(adress)
        //addSubview(basketButton)
        
       // stackForLabelAndSearchButton.addArrangedSubview(labelOfScreen)
        //stackForLabelAndSearchButton.addArrangedSubview(searchButton)
        //stackForLabelAndSearchButton.addArrangedSubview(finderBar.searchBar)
        //addSubview(stackForLabelAndSearchButton)
        
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
        
        stackForAllView.addArrangedSubview(stackForCollectionView)
        addSubview(stackForAllView)
    }
    func setConstraint() {
        NSLayoutConstraint.activate([
//            // StackOfBascet
//            basketAndAdressStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            basketAndAdressStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            basketAndAdressStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            basketAndAdressStackView.heightAnchor.constraint(equalToConstant: 30),
//                   
//            // Адрес
//            adress.leftAnchor.constraint(equalTo: basketAndAdressStackView.leftAnchor),
//            adress.widthAnchor.constraint(equalToConstant: 185.94),
//                   
//            basketButton.rightAnchor.constraint(equalTo: basketAndAdressStackView.rightAnchor),
            
//            adress.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            adress.heightAnchor.constraint(equalToConstant: 28),
//            adress.widthAnchor.constraint(equalToConstant: 185.94),
//            adress.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            
//            basketButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            basketButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            basketButton.heightAnchor.constraint(equalToConstant: 28),
//            
            
            // Уведомление
//            notificationLabel.widthAnchor.constraint(equalToConstant: 12),
//            notificationLabel.heightAnchor.constraint(equalToConstant: 12),
//            notificationLabel.centerXAnchor.constraint(equalTo: basketButton.centerXAnchor, constant: 9),
//            notificationLabel.centerYAnchor.constraint(equalTo: basketButton.centerYAnchor, constant: -9),
//            
            // StackOfSerch
            
//            stackForLabelAndSearchButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 20),
//            stackForLabelAndSearchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            stackForLabelAndSearchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            stackForLabelAndSearchButton.heightAnchor.constraint(equalToConstant: 36),
            
            //labelOfScreen.widthAnchor.constraint(equalTo: stackForLabelAndSearchButton.widthAnchor, multiplier: 0.3),
            //finderBar.searchBar.widthAnchor.constraint(equalTo: stackForLabelAndSearchButton.widthAnchor, multiplier: 0.7),
            //searchButton.widthAnchor.constraint(equalTo: stackForLabelAndSearchButton.widthAnchor, multiplier: 0.7),
            
            
            // Stack For All View
            stackForAllView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
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
