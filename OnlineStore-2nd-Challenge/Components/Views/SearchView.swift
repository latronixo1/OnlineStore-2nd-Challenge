//
//  SearchVoew.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 07.03.2025.
//

import UIKit

enum SearchSize {
    case big
    case small
}

final class SearchView: UIView, UISearchBarDelegate {
    let searchBar = UISearchBar()
    private var products: [Product] = []
    private let networkManager = NetworkService.shared
    private let userDefaults = FavoriteManager.shared
    private let searchLabelSmall = UILabel.makeLabel(text: "Search", font: .systemFont(ofSize: 16, weight: .regular), textColor: .systemGray4)
    private let searchLabelBig = UILabel.makeLabel(text: "Shop", font: .systemFont(ofSize: 28, weight: .bold), textColor: .black)
    
    private let searchSize: SearchSize

    init(searchSize: SearchSize) {
        self.searchSize = searchSize
        super.init(frame: .zero)
        
        setupView()
        setupSearchBar()
        setupLabel()
        setupTextField()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            topVC.present(searchViewController, animated: true, completion: nil)
        }
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
    }
    
    private func setupTextField() {
        if let searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchBarTextField.backgroundColor = .systemGray6
            searchBarTextField.textColor = .black
            searchBarTextField.borderStyle = .none
            searchBarTextField.leftView = nil
            searchBar.backgroundImage = UIImage()
            searchBarTextField.layer.cornerRadius = 24
        }
    }
    
    private func setupLabel() {
        let label = (searchSize == .big) ? searchLabelBig : searchLabelSmall
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    private func setConstraints() {
        let label = (searchSize == .big) ? searchLabelBig : searchLabelSmall

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: (searchSize == .big) ? 40 : 21),
            
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
}
