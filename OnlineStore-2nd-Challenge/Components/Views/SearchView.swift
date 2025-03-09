//
//  SearchVoew.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

final class SearchView: UIViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    private var product: [Product] = []
    private let networkManager = NetworkService.shared
    private let userDefaults = FavoriteManager.shared
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupTextField()
        setConstraints()
        
    }
    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        let searchViewController = FinderView()
//        
//       // navigationController?.pushViewController(searchViewController, animated: true)
//    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupTextField() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .systemGray6
            searchBarTextField.textColor = .black
            searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.lightGray])
            searchBarTextField.layer.cornerRadius = 12
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 40),
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
//         let searchResultVC = //контроллер с поиском
//        searchResultVC.articles = articles
//        searchResultVC.modalPresentationStyle = .pageSheet
//        present(searchResultVC, animated: true, completion: nil)
    
    }
}
