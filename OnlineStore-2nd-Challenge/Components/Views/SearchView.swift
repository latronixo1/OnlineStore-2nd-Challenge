//
//  SearchVoew.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

final class SearchView: UIViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    private var products: [Product] = []
    private let networkManager = NetworkService.shared
    private let userDefaults = FavoriteManager.shared
    private let searchLabel = UILabel.makeLabel(text: "Search", font: .systemFont(ofSize: 16, weight: .regular), textColor: .systemGray4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupTextField()
        setConstraints()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        pushFinderViewController()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    private func pushFinderViewController() {
        let searchViewController = FinderViewController()
        searchViewController.products = products
        searchViewController.modalPresentationStyle = .overFullScreen
        present(searchViewController, animated: true, completion: nil)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        view.addSubview(searchLabel)
    }
    
    private func setupTextField() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .systemGray6
            searchBarTextField.textColor = .black
            searchBarTextField.borderStyle = .none
            if let textField = searchBar.value(forKey: "searchField") as? UITextField {
                textField.leftView = nil
            }
            searchBar.backgroundImage = UIImage()
            searchBarTextField.layer.cornerRadius = 24
        }
    }
    
    private func setConstraints() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchLabel.heightAnchor.constraint(equalToConstant: 21),
            
            view.heightAnchor.constraint(equalToConstant: 40),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchLabel.trailingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
}
