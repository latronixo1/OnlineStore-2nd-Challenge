//
//  Finder VC.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 02.03.2025.
//


import UIKit

final class FinderViewController: UIViewController, SearchViewDelegate, UITextFieldDelegate {
    // MARK: - Properties
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "productCell"
    
    private let finderView = FinderView()
    private var searchHistoryModel: SearchHistoryModel
    private var emptyHistory: [String] = []
    private var selectedItemIndex: Int?
    var productsArray: [Product] = []
    var currentText = String()
    
    // MARK: - Init
    init(initialHistory: [String] = ["Socks", "Red dress", "Sunglasses", "Mustard Pants", "80-s Skirt"]) {
        self.searchHistoryModel = SearchHistoryModel(items: initialHistory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = finderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        
        setupLayout()
        collectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        finderView.searchField.text = currentText
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        finderView.addSubview(collectionView)
        
        setupHistoryCollection()
    }
    
    private func setupDelegates() {
        finderView.delegate = self
        finderView.searchField.delegate = self
    }
    
    private func setupHistoryCollection() {
        finderView.historyCollection.dataSource = self
        finderView.historyCollection.delegate = self
        finderView.historyCollection.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
    }
    
    // MARK: - Private Methods
    
    func saveCurrentText(text: String) {
        currentText = text
        print("\(currentText)")
    }
    
    private func performSearch() {
        if let searchText = finderView.searchField.text, !searchText.isEmpty {
            searchHistoryModel.addItem(searchText)
            finderView.historyCollection.reloadData()
        }
        finderView.searchField.resignFirstResponder()
    }
 
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

private extension FinderViewController {
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

// MARK: - FinderViewDelegate
extension FinderViewController: FinderViewDelegate {
    func textFieldDidChange() {
        finderView.searchField.text = currentText
    }
    
    func closeButtonTapped() {
        dismiss(animated: true)
    }
    
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
        finderView.historyCollection.reloadData()
    }
    
    func finderViewDidPressReturn() {
        performSearch()
    }
}
// MARK: - UICollectionViewDataSource
extension FinderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == finderView.historyCollection {
            return searchHistoryModel.items.count
        } else {
            return productsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == finderView.historyCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
                return UICollectionViewCell()
            }
            let history = searchHistoryModel.items[indexPath.item]
            cell.configure(with: history)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ShopCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if productsArray.isEmpty {
                print("No products found")
            } else {
                let product = productsArray[indexPath.row]
                cell.configure(model: product)
            }
            return cell
        }
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
        
        if !selectedText.isEmpty {
            finderView.searchField.text = selectedText
        } else {
            finderView.searchField.text = currentText
        }
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
