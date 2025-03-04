//
//  Finder VC.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 02.03.2025.
//


import UIKit

final class FinderViewController: UIViewController {
    
    // MARK: - Properties
    private let finderView = FinderView()
    private var searchHistoryModel: SearchHistoryModel
    private var selectedItemIndex: Int?
    
    // MARK: - Init
    init(initialHistory: [String] = ["Socks", "Red dress", "Sunglasses", "Mustard Pants", "80-s Skirt"]) {
        self.searchHistoryModel = SearchHistoryModel(items: initialHistory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = finderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        setupHistoryCollection()
    }
    
    private func setupDelegates() {
        finderView.delegate = self
    }
    
    private func setupHistoryCollection() {
        finderView.historyCollection.dataSource = self
        finderView.historyCollection.delegate = self
        finderView.historyCollection.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
    }
    
    // MARK: - Private Methods
    private func performSearch() {
        if let searchText = finderView.searchField.text, !searchText.isEmpty {
            searchHistoryModel.addItem(searchText)
            finderView.historyCollection.reloadData()
            
            let resultVC = UIViewController()
            resultVC.view.backgroundColor = .white
            resultVC.title = "Results for: \(searchText)"
            navigationController?.pushViewController(resultVC, animated: true)
        }
        finderView.searchField.resignFirstResponder()
    }
}

// MARK: - FinderViewDelegate
extension FinderViewController: FinderViewDelegate {
    func finderViewSearchButtonTapped() {
        performSearch()
    }
    
    func finderViewDeleteButtonTapped() {
        if let selectedIndex = selectedItemIndex {
            searchHistoryModel.removeItem(at: selectedIndex)
            selectedItemIndex = nil
        } else {
            searchHistoryModel.removeAllItems()
        }
        finderView.searchField.text = ""
        finderView.historyCollection.reloadData()
    }
    
    func finderViewDidPressReturn() {
        performSearch()
    }
}

// MARK: - UICollectionViewDataSource
extension FinderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchHistoryModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UICollectionViewCell()
        }
        let history = searchHistoryModel.items[indexPath.item]
        cell.configure(with: history)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FinderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == selectedItemIndex {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectedItemIndex = nil
            finderView.searchField.text = ""
            return
        }
        
        selectedItemIndex = indexPath.item
        
        for cell in collectionView.visibleCells {
            if let cellIndexPath = collectionView.indexPath(for: cell) {
                if cellIndexPath != indexPath {
                    collectionView.deselectItem(at: cellIndexPath, animated: false)
                }
            }
        }
        
        let selectedText = searchHistoryModel.items[indexPath.item]
        finderView.searchField.text = selectedText
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.item == selectedItemIndex {
            selectedItemIndex = nil
            finderView.searchField.text = ""
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FinderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = searchHistoryModel.items[indexPath.item]
        
        // Создаем временный label для расчета ширины текста
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.text = text
        label.sizeToFit()
        
        // Добавляем отступы для текста внутри ячейки (16 слева + 16 справа)
        let cellWidth = label.frame.width + 32
        
        return CGSize(width: cellWidth, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumInteritemSpacing: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumLineSpacing: Int) -> CGFloat {
        return 4
    }
}
