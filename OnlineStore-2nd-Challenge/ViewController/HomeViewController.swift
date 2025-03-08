//
//  HomeViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeViewController: UIViewController {
    private let productURLString = "https://fakestoreapi.com/products"
    let mainView: HomeView = .init()
    private var items: [Product] = []
    private var categories: [String] = []
    private var sortedPopularItems: [Product] = []
    private var favoriteItems: [Product] = []
    private var  makeImageForCategory: [String: [String]] = [:]
    
    private let favoriteManager = FavoriteManager.shared
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        setupCollectionViews()
        makeProduct()
        setupCollectionViewLayout()
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
            print("Словарь изображений: \(self.makeImageForCategory)")
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
    private func loadImages(from urls: [String], into imageViews: [UIImageView]) {
        for (index, url) in urls.enumerated() {
            guard index < imageViews.count else { break }
            NetworkService.shared.fetchImage(from: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        imageViews[index].image = image
                    case .failure:
                        imageViews[index].image = UIImage(systemName: "xmark.circle")
                    }
                }
            }
        }
    }
}


extension HomeViewController: UICollectionViewDelegate {
    
}
// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
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
            cell.discriptionLabel.text = sortedPopularItems[indexPath.row].description
            cell.priceLabel.text = "\(sortedPopularItems[indexPath.row].price) ₽"
            return cell
            
        case mainView.justForYouCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeJustForUCell.reuseIdentifier, for: indexPath) as? HomeJustForUCell else {
                return UICollectionViewCell()
            }
            
                ///нужно использовать ячейку такую же как на экране избранных
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
            
//            let selectedProduct = items[indexPath.row]
//            cell.isSelect = favoriteManager.isFavorite(product: selectedProduct)

            return cell
            
        default:
            fatalError("Unknown collection view")
        }
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 8 // Отступ между ячейками
        let itemsPerRow: CGFloat = 2 // Количество ячеек в строке
        let totalSpacing = (itemsPerRow - 1) * spacing + layout.sectionInset.left + layout.sectionInset.right
        let itemWidth = (view.bounds.width - totalSpacing) / itemsPerRow
        let itemHeight: CGFloat = 190 
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        mainView.categoryCollectionView.collectionViewLayout = layout
    }
}
