//
//  WishlistController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 04.03.2025.
//

import UIKit

final class WishlistViewController: UIViewController {
    
    private var product: [Product] = []
    
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "wishlist"
    private let navigation = UINavigationBar()
    private let finderBar = SearchView(searchSize: .small)
    private let favoriteManager = FavoriteManager.shared
    private let titleOfLabel = UILabel.makeLabel(text: "Wishlist", font: .systemFont(ofSize: 28, weight: .bold), textColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupNavigationBar()
        setupFinderView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFavorite()
    }
    
    func reloadFavorite() {
        product = favoriteManager.favoriteArray
        collectionView.reloadData()
    }
    

    
    func setupNavigationBar() {
        navigation.barTintColor = .white
        navigation.addSubview(titleOfLabel)
        view.addSubview(navigation)
    }
    
    func setupFinderView() {
        finderBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(finderBar)
    }
}


private extension WishlistViewController {
    func setupView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}


private extension WishlistViewController {
    func createLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(282)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(282)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 15,
            bottom: 0,
            trailing: 15
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension WishlistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteManager.favoriteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
        
        let content = favoriteManager.favoriteArray[indexPath.row]
        cell.configure(model: content)
        return cell
    }
}


extension WishlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if product.count > 0 {
            let selectedCell = product[indexPath.item]
            let productVC = ProductViewController(product: selectedCell)
            navigationController?.pushViewController(productVC, animated: true)
        }
    }
}

private extension WishlistViewController {
    func setupLayout() {
        navigation.translatesAutoresizingMaskIntoConstraints = false
        titleOfLabel.translatesAutoresizingMaskIntoConstraints = false
        finderBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 44),
            
            titleOfLabel.centerXAnchor.constraint(equalTo: navigation.centerXAnchor),
            titleOfLabel.bottomAnchor.constraint(equalTo: navigation.bottomAnchor, constant: -8),
            
            finderBar.topAnchor.constraint(equalTo: navigation.bottomAnchor, constant: 10),
            finderBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            finderBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            finderBar.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: finderBar.bottomAnchor, constant: 10),
        ])
    }
}
