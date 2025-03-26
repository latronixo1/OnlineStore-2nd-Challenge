//
//  WishlistController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 04.03.2025.
//

import UIKit

final class WishlistViewController: UIViewController {
    
    private var product: [Product] = FavoriteManager.shared.loadFavoriteProducts()
    
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "ProductCollectionViewCell"
    private let navigation = UINavigationBar()
    private let favoriteManager = FavoriteManager.shared
    private let titleOfLabel = UILabel.makeLabel(text: "Wishlist", font: .systemFont(ofSize: 28, weight: .bold), textColor: .black, numberOfLines: 1)
    private let labelSearch = UILabel.makeLabel(text: "Search", font: .systemFont(ofSize: 16, weight: .regular), textColor: .systemGray, numberOfLines: 1)
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 18
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        return textField
    }()
    var searchedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupNavigationBar()
        setupFinderView()
        setupLayout()
        searchTextField.delegate = self
        
        DispatchQueue.main.async {
            self.reloadFavorite()
            self.collectionView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteUpdate), name: Notification.Name("DidUpdateFavorites"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFavorite()
        collectionView.reloadData()
    }
    
    @objc func handleFavoriteUpdate() {
        reloadFavorite()
        collectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("DidUpdateFavorites"), object: nil)
    }
    
    func reloadFavorite() {
        product = favoriteManager.favoriteArray
        print("Обновление избранных товаров, найдено: \(product.count)")
    }
    
    func setupNavigationBar() {
        navigation.barTintColor = .white
        navigation.addSubview(titleOfLabel)
        view.addSubview(navigation)
    }
    
    func setupFinderView() {
        view.addSubview(labelSearch)
        view.addSubview(searchTextField)
    }
}


private extension WishlistViewController {
    func setupView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
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
        product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
        
        let content = product[indexPath.row]
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigation.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            navigation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigation.heightAnchor.constraint(equalToConstant: 44),
            
            titleOfLabel.centerXAnchor.constraint(equalTo: navigation.centerXAnchor),
            titleOfLabel.bottomAnchor.constraint(equalTo: navigation.bottomAnchor, constant: -8),
            
            labelSearch.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            labelSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            labelSearch.widthAnchor.constraint(equalToConstant: 60),
            
            searchTextField.topAnchor.constraint(equalTo: navigation.bottomAnchor, constant: 12),
            searchTextField.leadingAnchor.constraint(equalTo: labelSearch.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension WishlistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doSearch(textField.text)
        return true
    }
    
    private func doSearch(_ text: String?) {
        searchedText = text?.lowercased() ?? ""
        
        if searchedText.isEmpty {
            product = favoriteManager.loadFavoriteProducts()
        } else {
            product = favoriteManager.loadFavoriteProducts().filter{ $0.title.lowercased().contains(searchedText.lowercased()) }
        }
        collectionView.reloadData()
    }
}
