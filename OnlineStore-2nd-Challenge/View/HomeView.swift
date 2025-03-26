//
//  HomeView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Main Scroll View
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    //MARK: CATEGORIES
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
    
    // MARK: - Main Stack
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)

        categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        popularCollectionView.register(HomePopularCell.self, forCellWithReuseIdentifier: HomePopularCell.reuseIdentifier)


        // Configure category section
        mainStackView.addArrangedSubview(stackForCategoryView)
        
        stackForCategoryView.addArrangedSubview(stackForLabelCategory)

        stackForLabelCategory.addArrangedSubview(categoryLabel)
        stackForLabelCategory.addArrangedSubview(categoryButton)

        stackForCategoryView.addArrangedSubview(categoryCollectionView)

        
        // Configure popular section
        mainStackView.addArrangedSubview(stackForPopularView)
        
        stackForPopularView.addArrangedSubview(stackForLabelPopular)
        
        stackForLabelPopular.addArrangedSubview(popularLabel)
        stackForLabelPopular.addArrangedSubview(popularButton)

        stackForPopularView.addArrangedSubview(popularCollectionView)
      }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 190),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Main Stack View
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Category Section
            stackForLabelCategory.heightAnchor.constraint(equalToConstant: 30),
            stackForLabelCategory.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            stackForLabelCategory.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            categoryButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 400),
            categoryCollectionView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            // Popular Section
            stackForLabelPopular.heightAnchor.constraint(equalToConstant: 30),
            stackForLabelPopular.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            stackForLabelPopular.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            popularButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

            popularCollectionView.heightAnchor.constraint(equalToConstant: 250),
            popularCollectionView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            popularCollectionView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

        ])
    }
}
