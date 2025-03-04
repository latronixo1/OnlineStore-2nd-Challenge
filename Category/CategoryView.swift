//
//  CategoryView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 04.03.2025.
//

import UIKit

final class CategoryView: UIView {
    
    // MARK: - UI Elements
    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.contentMode = .scaleAspectFill
        backView.translatesAutoresizingMaskIntoConstraints = false
        return backView
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    private let allCategoriesLabel: UILabel = {
        let allCategoriesLabel = UILabel()
        allCategoriesLabel.text = "All Categories"
        allCategoriesLabel.font = .systemFont(ofSize: 28, weight: .bold)
        allCategoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        return allCategoriesLabel
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.register(SubcategoryCell.self, forCellWithReuseIdentifier: SubcategoryCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(backView)
        backView.addSubview(closeButton)
        backView.addSubview(allCategoriesLabel)
        backView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 14),
            closeButton.widthAnchor.constraint(equalToConstant: 14),
            closeButton.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 11),
            closeButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            allCategoriesLabel.heightAnchor.constraint(equalToConstant: 36),
            allCategoriesLabel.widthAnchor.constraint(equalToConstant: 185),
            allCategoriesLabel.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 4),
            allCategoriesLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: allCategoriesLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
