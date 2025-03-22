//
//  ShopViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 20.03.2025.
//

import UIKit

final class ShopViewController: UIViewController {
    
    var products: [Product] = []
    var currency: String = ""
    var searchedText = ""
    var filteredProducts: [Product] = []
    let historyManager = HistoryManager()
    let currencyManager = CurrencyManager()
   
    
    
    private var searchHistory: [String] = []
    
    private lazy var shopTitle: UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "Search history"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 18
        textField.placeholder = "Search"
        textField.text = searchedText
        textField.translatesAutoresizingMaskIntoConstraints = false
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftPadding
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        config.preferredSymbolConfigurationForImage = .init(pointSize: 24, weight: .regular, scale: .default)
        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearSearchHistoryButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        config.preferredSymbolConfigurationForImage = .init(pointSize: 24, weight: .regular, scale: .default)
        let button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(clearSearchHistoryTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var collectionViewWithChips: UICollectionView = {
        let layout = ChipsCollectionViewLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(ChipsCollectionViewCell.self, forCellWithReuseIdentifier: ChipsCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var collectionProductsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(currencyDidChange), name: .currencyDidChange, object: nil)
        searchHistory = historyManager.getAllSearchHistory()
        currency = currencyManager.getCurrency()
        
        navigationController?.isNavigationBarHidden = true
        setupUI()
        searchTextField.delegate = self
        
        if products == filteredProducts {
            if filteredProducts.isEmpty {
                updateUIWhenEmpty()
            } else {
                collectionProductsView.isHidden = false
                historyLabel.isHidden = true
                clearSearchHistoryButton.isHidden = true
                collectionViewWithChips.isHidden = true
            }
            collectionProductsView.reloadData()
            collectionViewWithChips.reloadData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if searchedText.isEmpty {
            filteredProducts = products
        }
        
        if filteredProducts.isEmpty {
            updateUIWhenEmpty()
        }
        
        collectionProductsView.reloadData()
        collectionViewWithChips.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func closeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func currencyDidChange() {
        currency = currencyManager.getCurrency()
    }
    
    @objc func clearSearchHistoryTapped() {
        historyManager.clearSearchHistory()
        searchHistory = []
        collectionViewWithChips.reloadData()
    }
}

private extension ShopViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(shopTitle)
        view.addSubview(searchTextField)
        
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        shopTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21).isActive = true
        shopTitle.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8).isActive = true
        shopTitle.heightAnchor.constraint(equalToConstant: 36).isActive = true
        shopTitle.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        searchTextField.leftAnchor.constraint(equalTo: shopTitle.rightAnchor, constant: 19).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -21).isActive = true
        searchTextField.topAnchor.constraint(equalTo: shopTitle.topAnchor, constant: 0).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        view.addSubview(collectionViewWithChips)
        collectionViewWithChips.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21).isActive = true
        collectionViewWithChips.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -21).isActive = true
        collectionViewWithChips.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
        collectionViewWithChips.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(collectionProductsView)
        collectionProductsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21).isActive = true
        collectionProductsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -21).isActive = true
        collectionProductsView.topAnchor.constraint(equalTo: collectionViewWithChips.bottomAnchor, constant: 10).isActive = true
        collectionProductsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(historyLabel)
        view.addSubview(clearSearchHistoryButton)
        
        historyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21).isActive = true
        historyLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        historyLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        clearSearchHistoryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -21).isActive = true
        clearSearchHistoryButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func updateUIWhenEmpty() {
        if filteredProducts.isEmpty {
            collectionProductsView.isHidden = true
            historyLabel.isHidden = false
            clearSearchHistoryButton.isHidden = false
            collectionViewWithChips.isHidden = false
        } else {
            collectionProductsView.isHidden = false
            historyLabel.isHidden = true
            clearSearchHistoryButton.isHidden = true
            collectionViewWithChips.isHidden = true
        }
    }
    
    
    func removeQuery(at index: Int) {
        searchHistory.remove(at: index)
        historyManager.saveSearchHistory(searchHistory)
        collectionViewWithChips.reloadData()
    }
}

extension ShopViewController: ChipsCollectionViewCellDelegate {
    func deleteButtonTapped(in cell: ChipsCollectionViewCell) {
        guard let indexPath = collectionViewWithChips.indexPath(for: cell) else { return }
        searchHistory.remove(at: indexPath.item)
        
        historyManager.saveSearchHistory(searchHistory)
        
        historyManager.saveSearchHistory(searchHistory)
        collectionViewWithChips.deleteItems(at: [indexPath])
        
        if historyManager.getAllSearchHistory().isEmpty {
            clearSearchHistoryButton.isHidden = true
        }
        
    }
}

extension ShopViewController: UICollectionViewDelegate {}

extension ShopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionProductsView {
            return !searchedText.isEmpty ? filteredProducts.count : products.count
        }
        
        if collectionView == collectionViewWithChips {
            return searchHistory.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionProductsView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
            let dataSource = !searchedText.isEmpty ? filteredProducts : products
            let product = dataSource[indexPath.row]
            cell.configure(model: product)
            return cell
        }
        
        if collectionView == collectionViewWithChips {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipsCollectionViewCell.identifier, for: indexPath) as! ChipsCollectionViewCell
            let query = searchHistory[indexPath.item]
            cell.configure(with: query)
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionProductsView {
            let selectedProduct: Product
            
            if filteredProducts.isEmpty {
                selectedProduct = products[indexPath.row]
            } else {
                selectedProduct = filteredProducts[indexPath.row]
            }
            
            let vc = ProductViewController(product: selectedProduct)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            navigationController?.isNavigationBarHidden = false
            navigationItem.backButtonTitle = ""
        }
    }
}



extension ShopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewWithChips {
            let query = searchHistory[indexPath.row]
            let font = UIFont.systemFont(ofSize: 12, weight: .regular)
            let textWidth = (query as NSString).size(withAttributes: [.font: font]).width
            let padding: CGFloat = 44
            let cellWidth = textWidth + padding
            
            let maxWidth = collectionView.bounds.width
            let width = min(cellWidth, maxWidth)
            
            return CGSize(width: width, height: 28)
        }
        if collectionView == collectionProductsView {
            return CGSize(width: (collectionView.bounds.width / 2) - 4, height: 280)
        }
        return .zero
    }
}

extension ShopViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchedText = textField.text?.lowercased() ?? ""
        
        if !searchedText.isEmpty {
            historyManager.addSearchQuery(searchedText)
            searchHistory = historyManager.getAllSearchHistory()
            collectionViewWithChips.reloadData()
        }
        
        if searchedText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter {
                $0.title.lowercased().contains(searchedText)
            }
        }
        
        collectionProductsView.reloadData()
        
        if filteredProducts.isEmpty {
            updateUIWhenEmpty()
        } else {
            collectionProductsView.isHidden = false
            historyLabel.isHidden = true
            clearSearchHistoryButton.isHidden = true
            collectionViewWithChips.isHidden = true
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchedText = ""
        
        filteredProducts = products
        
        textField.resignFirstResponder()
        
        collectionProductsView.isHidden = false
        historyLabel.isHidden = true
        clearSearchHistoryButton.isHidden = true
        collectionViewWithChips.isHidden = true
        
        collectionProductsView.reloadData()
        return true
    }
}
