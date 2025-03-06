//
//  HomeViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeViewController: UIViewController {
    let mainView: HomeView = .init()
    private var items: [Product] = []
    private var categories: [String] = []
    private var sortedPopularItems: [Product] = []
    private var favoriteItems: [Product] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        setupCollectionViews()
        makeProduct()
    }
    
    private func setupCollectionViews() {
        mainView.categoryCollectionView.delegate = self
        mainView.categoryCollectionView.dataSource = self
        mainView.categoryCollectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
        mainView.categoryCollectionView.register(HeaderHomeCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderHomeCollectionView.reuseIdentifier)
        
        mainView.popularCollectionView.delegate = self
        mainView.popularCollectionView.dataSource = self
        mainView.popularCollectionView.register(HomePopularCell.self, forCellWithReuseIdentifier: HomePopularCell.reuseIdentifier)
        mainView.popularCollectionView.register(HeaderHomeCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderHomeCollectionView.reuseIdentifier)
        
        mainView.justForYouCollectionView.delegate = self
        mainView.justForYouCollectionView.dataSource = self
        mainView.justForYouCollectionView.register(HomeJustForUCell.self, forCellWithReuseIdentifier: HomeJustForUCell.reuseIdentifier)
        mainView.justForYouCollectionView.register(HeaderHomeCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderHomeCollectionView.reuseIdentifier)
    }
    
    private func makeProduct() {
        NetworkService.shared.fetchProducts { result in
            switch result {
            case .success(let products):
                self.items = products
                let newCategories = products.map { $0.category }
                self.categories = Array(Set(newCategories)).sorted()
                UserDefaults.standard.set(self.categories, forKey: UserDefaultsStorageKeys.category.label)
                self.sortedPopularItems = self.items.sorted { $0.rating.rate > $1.rating.rate }
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.mainView.categoryCollectionView.reloadData()
                self.mainView.popularCollectionView.reloadData()
                self.mainView.justForYouCollectionView.reloadData()
            }
            
            print("Категории: \(self.categories)")
            print("Продукты загружены: \(self.items.count)")
        }
    }
    
    func addToFavorite(item: Product) {
        if !favoriteItems.contains(where: { $0.id == item.id }) {
            favoriteItems.append(item)
            print("Продукт добавлен в избранное: \(item.description)")
        } else {
            print("Продукт уже в избранном")
        }
    }
    
    // MARK: Navigation
    @objc func categoryHeaderTapped() {
        // Handle category header tap
    }
    
    @objc func popularHeaderTapped() {
        // Handle popular header tap
    }
    
    @objc func justForUHeaderTapped() {
        // Handle just for you header tap
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderHomeCollectionView.reuseIdentifier, for: indexPath) as? HeaderHomeCollectionView else {
            return UICollectionReusableView()
        }
        
        if collectionView == mainView.categoryCollectionView {
            header.labelForHomeCollectionView.text = "Category"
            header.buttonForHomeCollectionView.addTarget(self, action: #selector(categoryHeaderTapped), for: .touchUpInside)
        } else if collectionView == mainView.popularCollectionView {
            header.labelForHomeCollectionView.text = "Popular"
            header.buttonForHomeCollectionView.addTarget(self, action: #selector(popularHeaderTapped), for: .touchUpInside)
        } else if collectionView == mainView.justForYouCollectionView {
            header.labelForHomeCollectionView.text = "Just For You"
            header.buttonForHomeCollectionView.addTarget(self, action: #selector(justForUHeaderTapped), for: .touchUpInside)
        }
        
        return header
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.categoryCollectionView:
            return categories.count
        case mainView.popularCollectionView:
            return sortedPopularItems.count
        case mainView.justForYouCollectionView:
            return items.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseIdentifier, for: indexPath) as? HomeCategoryCell else {
                return UICollectionViewCell()
            }
            cell.labelOfCategory.text = categories[indexPath.row]
            cell.quantityOfProducts.text = "\(items.filter { $0.category == categories[indexPath.row] }.count)"
            return cell
            
        case mainView.popularCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePopularCell.reuseIdentifier, for: indexPath) as? HomePopularCell else {
                return UICollectionViewCell()
            }
            cell.discriptionLabel.text = sortedPopularItems[indexPath.row].description
            cell.priceLabel.text = "\(sortedPopularItems[indexPath.row].price) ₽"
            return cell
            
        case mainView.justForYouCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeJustForUCell.reuseIdentifier, for: indexPath) as? HomeJustForUCell else {
                return UICollectionViewCell()
            }
            return cell
            
        default:
            fatalError("Unknown collection view")
        }
    }
}
