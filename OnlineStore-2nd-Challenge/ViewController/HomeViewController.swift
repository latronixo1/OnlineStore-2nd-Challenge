//
//  HomeViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let productURLString = "https://fakestoreapi.com/products"
    let mainView: HomeView = .init()
    private var items: [Product] = []
    private var categories: [String] = []
    private var sortedPopularItems: [Product] = []
    private var favoriteItems: [Product] = []
    private var makeImageForCategory: [String: [String]] = [:]
    
    private let favoriteManager = FavoriteManager.shared
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        setupCollectionViews()
        makeProduct()
        setupNavigation()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    private func setupCollectionViews() {
        mainView.categoryCollectionView.delegate = self
        mainView.categoryCollectionView.dataSource = self
        mainView.popularCollectionView.delegate = self
        mainView.popularCollectionView.dataSource = self
    }
    private func setupNavigation() {
        mainView.basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        mainView.categoryButton.addTarget(self, action: #selector(categoriesButtonTapped), for: .touchUpInside)
    }
    
    //MARK: FETCH_PRODUCTS
    private func makeProduct() {
        NetworkService.shared.fetchProducts(from: productURLString) { result in
            switch result {
            case .success(let products):
                self.items = products
                let newCategories = products.map { $0.category }
                UserDefaultsManager.shared.saveProducts(products)
                self.categories = Array(Set(newCategories)).sorted()
                UserDefaults.standard.set(self.categories, forKey: UserDefaultsStorageKeys.category.label)
                
                var imageLinksByCategory: [String: [String]] = [:]
                for product in self.items {
                    if var links = imageLinksByCategory[product.category] {
                        links.append(product.image)
                        imageLinksByCategory[product.category] = links
                    } else {
                        imageLinksByCategory[product.category] = [product.image]
                    }
                }
                self.makeImageForCategory = imageLinksByCategory
                
                self.sortedPopularItems = self.items.sorted { $0.rating.rate > $1.rating.rate }
                print("отсортированный массив\(self.sortedPopularItems)")
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.mainView.categoryCollectionView.reloadData()
                self.mainView.popularCollectionView.reloadData()
            }
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
    
    private func loadImages(from urls: [String], into imageViews: [UIImageView]) {
        for (index, url) in urls.enumerated() {
            guard index < imageViews.count else { break }
            NetworkService.shared.fetchImage(from: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        imageViews[index].image = image
                    case .failure(let error):
                        print("Ошибка загрузки изображения: \(error.localizedDescription)")
                        imageViews[index].image = UIImage(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
    //MARK: Navigation
    @objc func basketButtonTapped() {
        guard let tapBar = self.tabBarController else {
            print("Ошбка в получении тап бара")
            return
        }
        tapBar.selectedIndex = 3
    }
    @objc func categoriesButtonTapped() {
        guard let tapBar = self.tabBarController else { return }
        tapBar.selectedIndex = 2
    }
}

extension HomeViewController: UICollectionViewDelegate {}

//MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.categoryCollectionView:
            return categories.count
        case mainView.popularCollectionView:
            return sortedPopularItems.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseIdentifier, for: indexPath) as? HomeCategoryCell else {
                return UICollectionViewCell()
            }
            let category = categories[indexPath.row]
            cell.labelOfCategory.text = category
            cell.quantityOfProducts.text = "\(items.filter { $0.category == category }.count)"
            if let imageLinks = makeImageForCategory[category], imageLinks.count >= 4 {
                       loadImages(from: Array(imageLinks.prefix(4)), into: [cell.firstImageView, cell.secondImageView, cell.thirdImageView, cell.fourthImageView])
            } else {
                [cell.firstImageView, cell.secondImageView, cell.thirdImageView, cell.fourthImageView].forEach {
                    $0.image = UIImage(systemName: "plus")
                }
            }
            return cell
            
        case mainView.popularCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePopularCell.reuseIdentifier, for: indexPath) as? HomePopularCell else {
                return UICollectionViewCell()
            }
            cell.discriptionOfProduct.text = sortedPopularItems[indexPath.row].description
            cell.priceOfProducts.text = "\(sortedPopularItems[indexPath.row].price) ₽"
            let urlOfImage = self.sortedPopularItems[indexPath.row].image
            cell.photoOfProduct.image = nil
            NetworkService.shared.fetchImage(from: urlOfImage) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let makeImage) :
                        cell.photoOfProduct.image = makeImage
                        print("Фотка для ячейки готова")
                    case .failure(let error):
                        print(error)
                        print("Очибка")
                    }
                }
            }
                
            return cell
            
        default:
            fatalError("Unknown collection view")
        }
    }
    
}
//MARK: UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let itemsPerRow: CGFloat = 2
        let totalSpacing = (itemsPerRow - 1) * spacing
        let itemWidth = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        return CGSize(width: itemWidth, height: 190)
    }
}
