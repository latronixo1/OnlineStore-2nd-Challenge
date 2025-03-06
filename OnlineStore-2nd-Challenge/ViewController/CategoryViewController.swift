//
//  CategoryController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 04.03.2025.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    // MARK: - Properties
    private var categories: [Category] = Category.mockData()
    private let categoryView = CategoryView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = categoryView
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupDelegates()
            setupActions()
        }
        
        // MARK: - Setup
        private func setupDelegates() {
            categoryView.collectionView.delegate = self
            categoryView.collectionView.dataSource = self
        }
        
        private func setupActions() {
            categoryView.closeButton.addTarget(
                self,
                action: #selector(closeButtonTapped),
                for: .touchUpInside
            )
        }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
           // Переход на HomeViewController
           if let homeVC = navigationController?.viewControllers.first(where: { $0 is HomeViewController }) {
               navigationController?.popToViewController(homeVC, animated: true)
           } else {
               let homeVC = HomeViewController()
               navigationController?.setViewControllers([homeVC], animated: true)
           }
       }
    }
    
// MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = categories[section]
        return 1 + (category.isExpanded ? (category.subcategories?.count ?? 0) : 0)
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
            cell.configure(with: category.subcategories![indexPath.item - 1])
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
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        } else {
            // Переход на HomeViewController при выборе подкатегории
            let homeVC = HomeViewController()
            navigationController?.pushViewController(homeVC, animated: true)
            
            // Снимаем выделение с ячейки
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
            : CGSize(width: (width - 10) / 2, height: 44) // Изменено с 16 на 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0) // Отступ между секциями
    }
}
