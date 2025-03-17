//
//  CategoryController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 04.03.2025.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    // MARK: - Properties
    private var categories: [Category] = []
    private let categoryView = CategoryView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "All Categories"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegates()
        fetchCategories() // Добавляем этот вызов
    }
    
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        // Настраиваем левую часть навбара (заголовок)
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        navigationItem.hidesBackButton = true
        
        // Убираем разделительную линию навбара
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Setup
    private func setupDelegates() {
        categoryView.collectionView.delegate = self
        categoryView.collectionView.dataSource = self
    }
    
    // MARK: - Method
    private func fetchCategories() {
        NetworkService.shared.fetchProducts(from: "https://fakestoreapi.com/products") { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let products):
                    // Получаем уникальные категории и сортируем их в нужном порядке
                    let uniqueCategories = Array(Set(products.map { $0.category }))
                    let sortedCategories = self.sortCategories(uniqueCategories)
                    
                    // Создаем массив категорий с кастомными подкатегориями и иконками
                    self.categories = sortedCategories.map { title in
                        Category(
                            title: title,
                            icon: Category.getCustomIcon(for: title),
                            subcategories: Category.getCustomSubcategories(for: title),
                            isExpanded: false
                        )
                    }
                    
                    // Сохраняем названия категорий в UserDefaults
                    let categoryTitles = self.categories.map { $0.title }
                    if let encodedData = try? JSONEncoder().encode(categoryTitles) {
                        UserDefaults.standard.set(encodedData, forKey: UserDefaultsStorageKeys.category.label)
                    }
                    
                    self.categoryView.collectionView.reloadData()
                    
                case .failure(let error):
                    print("Error fetching categories: \(error)")
                    
                    // Пробуем загрузить из UserDefaults
                    if let savedData = UserDefaults.standard.data(forKey: UserDefaultsStorageKeys.category.label),
                       let savedCategories = try? JSONDecoder().decode([String].self, from: savedData) {
                        
                        self.categories = savedCategories.enumerated().map { index, title in
                            Category(
                                title: title,
                                icon: Category.getCustomIcon(for: title),
                                subcategories: Category.getCustomSubcategories(for: title),
                                isExpanded: false
                            )
                        }
                        self.categoryView.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func sortCategories(_ categories: [String]) -> [String] {
        let order = ["men's clothing", "electronics", "women's clothing", "jewelery"]
        return categories.sorted { first, second in
            guard let index1 = order.firstIndex(of: first),
                  let index2 = order.firstIndex(of: second) else {
                return false
            }
            return index1 < index2
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = categories[section]
        return 1 + (category.isExpanded ? category.subcategories.count : 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.section]
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath
            ) as! CategoryCell
            cell.configure(with: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SubcategoryCell.reuseIdentifier,
                for: indexPath
            ) as! SubcategoryCell
            cell.configure(with: category.subcategories[indexPath.item - 1])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            // Логика для категории остается прежней
            for (index, _) in categories.enumerated() where index != indexPath.section && categories[index].isExpanded {
                categories[index].isExpanded = false
                collectionView.reloadSections(IndexSet(integer: index))
            }
            
            categories[indexPath.section].isExpanded.toggle()
            
            if let encodedData = try? JSONEncoder().encode(categories) {
                UserDefaults.standard.set(encodedData, forKey: UserDefaultsStorageKeys.category.label)
            }
            
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        } else {
            // Получаем название выбранной подкатегории
            let category = categories[indexPath.section]
            
            // Создаем и настраиваем HomeViewController
            let homeVC = HomeViewController()
            navigationController?.pushViewController(homeVC, animated: true)
            
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width
        return indexPath.item == 0
        ? CGSize(width: width, height: 60)
        : CGSize(width: (width - 10) / 2, height: 44)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0) // Отступ между секциями
    }
}
