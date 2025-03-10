//
//  HomeView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import Foundation

import UIKit

class HomeView: UIView {
    
    lazy var adress: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    lazy var bascetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.text = "Shop"
        label.textColor = .black
        return label
    }()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        return searchBar
    }()
    lazy var labelForHeaderCategory: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.textColor = .black
        return label
    }()
    lazy var buttonForHeaderCategory: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.tintColor = .black
        return button
    }()
    lazy var stackforHeaderCategory: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelForHeaderCategory, buttonForHeaderCategory])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        return tableView
    }()
    lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    lazy var justForYouTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        return tableView
    }()
    lazy var scrollForView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    lazy var stakeView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    init() {
        super.init(frame: .zero)
        setView()
        setConstraint()
    }
    
    func setView(){
//        addSubview(adress) надо добавить реализацию адреса
        addSubview(bascetButton)
        stakeView.addArrangedSubview(shopLabel)
        stakeView.addArrangedSubview(searchBar)
        addSubview(stakeView)
        addSubview(categoryTableView)
        addSubview(popularCollectionView)
//        popularCollectionView
        addSubview(justForYouTableView)
        addSubview(scrollForView)
        
        categoryTableView.tableHeaderView = stackforHeaderCategory
        bascetButton.translatesAutoresizingMaskIntoConstraints = false
        stakeView.translatesAutoresizingMaskIntoConstraints = false
        categoryTableView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        justForYouTableView.translatesAutoresizingMaskIntoConstraints = false
        scrollForView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            bascetButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bascetButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
