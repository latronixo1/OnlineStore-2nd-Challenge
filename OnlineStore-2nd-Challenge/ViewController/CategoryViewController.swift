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
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
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
        setupActions()
        fetchCategories() // Добавляем этот вызов
    }
    
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        // Настраиваем левую часть навбара (заголовок)
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        // Настраиваем правую часть навбара (кнопка закрытия)
        let closeItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = closeItem
        
        // Убираем разделительную линию навбара
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Setup
    private func setupDelegates() {
        categoryView.collectionView.delegate = self
        categoryView.collectionView.dataSource = self
    }
    
    private func setupActions() {
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
//        if let tabBarController = self.view.window?.rootViewController as? UITabBarController {
//            tabBarController.selectedIndex = 0 // Переключаемся на первый таб
            navigationController?.popToRootViewController(animated: true)
//        }
    }
    
    // MARK: - Method
    private func fetchCategories() {
        NetworkService.shared.fetchProducts(from: "https://fakestoreapi.com/products") { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let products):
                    // Получаем уникальные категории
                    let uniqueCategories = Array(Set(products.map { $0.category }))
                    
                    // Создаем массив категорий с кастомными подкатегориями и иконками
                    self.categories = uniqueCategories.enumerated().map { index, title in
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
            // Закрываем предыдущую открытую категорию
            for (index, _) in categories.enumerated() where index != indexPath.section && categories[index].isExpanded {
                categories[index].isExpanded = false
                collectionView.reloadSections(IndexSet(integer: index))
            }
            
            // Открываем/закрываем выбранную категорию
            categories[indexPath.section].isExpanded.toggle()
            
            // Сохраняем обновленное состояние в UserDefaults
            if let encodedData = try? JSONEncoder().encode(categories) {
                UserDefaults.standard.set(encodedData, forKey: UserDefaultsStorageKeys.category.label)
            }
            
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        } else {
            // Переход на HomeViewController при выборе подкатегории
            let homeVC = HomeViewController(); // Добавлена точка с запятой
            navigationController?.pushViewController(homeVC, animated: true);  // Добавлена точка с запятой
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
