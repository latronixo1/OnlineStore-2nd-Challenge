//
//  Finder View.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 02.03.2025.
//


import UIKit

protocol FinderViewDelegate: AnyObject {
    func finderViewSearchButtonTapped()
    func finderViewDeleteButtonTapped()
    func finderViewDidPressReturn()
    func closeButtonTapped()
    func textFieldDidChange()
}

final class FinderView: UIView {
    weak var delegate: FinderViewDelegate?
    private var products: [Product] = []
    
    // MARK: - UI Elements
    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.contentMode = .scaleAspectFill
        backView.translatesAutoresizingMaskIntoConstraints = false
        return backView
    }()
    
    private var closeButton = UIButton()
    
    private lazy var shopLabel: UILabel = {
        let shopLabel = UILabel()
        shopLabel.text = "Shop"
        shopLabel.textColor = .black
        shopLabel.font = .boldSystemFont(ofSize: 28)
        shopLabel.translatesAutoresizingMaskIntoConstraints = false
        return shopLabel
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemGray3
        return button
    }()
    
    lazy var searchField: UITextField = {
        let searchField = UITextField()
        searchField.borderStyle = .none
        searchField.backgroundColor = .systemGray6
        searchField.layer.cornerRadius = 18
        searchField.layer.masksToBounds = true
        searchField.placeholder = "Search"
        
        searchField.delegate = self
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 36))
        searchField.leftView = leftPaddingView
        searchField.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 36))
        rightPaddingView.addSubview(searchButton)
        searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 36)
        
        searchField.rightView = rightPaddingView
        searchField.rightViewMode = .always
        
        searchField.returnKeyType = .search
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return searchField
    }()
    
    lazy var searchHistoryLabel: UILabel = {
        let searchHistoryLabel = UILabel()
        searchHistoryLabel.text = "Search history"
        searchHistoryLabel.textColor = .black
        searchHistoryLabel.font = .systemFont(ofSize: 18)
        searchHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return searchHistoryLabel
    }()
    
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.backgroundColor = .systemGray6
        deleteButton.layer.cornerRadius = 17.5
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    lazy var historyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = .zero
        return collection
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        //setupCloseButton()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(backView)
        backView.addSubview(shopLabel)
        backView.addSubview(searchField)
        //backView.addSubview(closeButton)
        backView.addSubview(searchHistoryLabel)
        backView.addSubview(deleteButton)
        backView.addSubview(historyCollection)
    }
    
    func setupCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shopLabel.heightAnchor.constraint(equalToConstant: 36),
            shopLabel.widthAnchor.constraint(equalToConstant: 68),
            shopLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            shopLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 24),
            
//            closeButton.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 8),
//            closeButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
//            closeButton.widthAnchor.constraint(equalToConstant: 32),
//            closeButton.heightAnchor.constraint(equalToConstant: 32),
            
            searchField.leadingAnchor.constraint(equalTo: shopLabel.trailingAnchor, constant: 12),
            searchField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            searchField.centerYAnchor.constraint(equalTo: shopLabel.centerYAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 36),
            
            searchHistoryLabel.heightAnchor.constraint(equalToConstant: 23),
            searchHistoryLabel.widthAnchor.constraint(equalToConstant: 118),
            searchHistoryLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            searchHistoryLabel.topAnchor.constraint(equalTo: shopLabel.bottomAnchor, constant: 18),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 35),
            deleteButton.widthAnchor.constraint(equalToConstant: 35),
            deleteButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            deleteButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 11),
            
            historyCollection.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            historyCollection.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            historyCollection.topAnchor.constraint(equalTo: searchHistoryLabel.bottomAnchor, constant: 16),
            historyCollection.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupActions() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func deleteButtonTapped() {
        delegate?.finderViewDeleteButtonTapped()
    }
    
    @objc private func searchButtonTapped() {
        delegate?.finderViewSearchButtonTapped()
    }
    
    @objc func tapClose() {
        delegate?.closeButtonTapped()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange()
    }
    
}

// MARK: - UITextFieldDelegate
extension FinderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.finderViewDidPressReturn()
        return true
    }
}
