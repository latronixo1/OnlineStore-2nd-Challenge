//
//  SearchVoew.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

protocol SearchViewDelegate {
    func saveCurrentText(text: String)
    func finderViewSearchButtonTapped()
    
}

final class SearchView: UIViewController, UISearchBarDelegate {
    private let productURLString = "https://fakestoreapi.com/products"
    let searchBar = UISearchBar()
    private var productsArray: [Product] = []
    private var imageArray: [UIImageView] = []
    private var productsModel: [Product]?
    private let networkManager = NetworkService.shared
    var delegate: SearchViewDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    var filteredProducts: [Product] = []
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: - - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSearchBar()
        setupTextField()
        setConstraints()
    }
    
    
    //MARK: - Private Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text, !searchTerm.isEmpty {
            loadProducts(searchTerm)
            
        }
    }
    
    private func loadProducts(_ text: String) {
        networkManager.fetchProducts(from: productURLString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    print("Продукты загружены: \(products.count)")
                    print("Success: \(products)")
                    self?.productsArray = products
                    self?.filterContextForSearchText(text)
                    self?.presentSearchScreen()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print("Ошибка загрузки: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .black
        }
    }
    
    
    //MARK: - Setup UI
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = .black
        
        view.addSubview(searchBar)
    }
    
    private func setupTextField() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .systemGray6
            searchBarTextField.textColor = .black
            searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.lightGray])
            searchBarTextField.layer.cornerRadius = 12
            if let glassIconView = searchBarTextField.leftView as? UIImageView {
                glassIconView.tintColor = .darkGray
            }
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 56),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
    
    private func presentSearchScreen() {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        filterContextForSearchText(searchText)
       
        self.delegate?.saveCurrentText(text: searchText)
        print("\(searchText)")
        
        if !filteredProducts.isEmpty {
            //let finderVC = FinderViewController()
//            finderVC.productsArray = filteredProducts
//            finderVC.currentText = searchText
//            let navController = UINavigationController(rootViewController: finderVC)
//            navController.sheetPresentationController?.prefersGrabberVisible = true
//            present(navController, animated: true, completion: nil)
            
//            let searchResultVC = FinderViewController()
//            searchResultVC.productsArray = filteredProducts
//            searchResultVC.currentText = searchText 
//            searchResultVC.modalPresentationStyle = .pageSheet
//            present(searchResultVC, animated: true, completion: nil)
        } else {
            print("No products found for search term: \(searchText)")
        }
    }
    
}

extension SearchView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContextForSearchText(searchText)
        print("Поиск: \(searchText), Найдено: \(filteredProducts.count)")
    }
    
    func filterContextForSearchText(_ searchText: String) {
        filteredProducts = productsArray.filter { product in
            product.title.lowercased().contains(searchText.lowercased())
        }
    }
}

