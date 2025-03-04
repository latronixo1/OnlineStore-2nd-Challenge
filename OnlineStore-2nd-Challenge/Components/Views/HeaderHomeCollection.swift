//
//  HeaderHomeCollection.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HeaderHomeCollection: UICollectionReusableView {
    static let reuseIdentifier = "HeaderHomeCollection"
    lazy var labelForPopularCollectionView: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.textColor = .black
        return label
    }()
    lazy var buttonForPopularCollectionView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.tintColor = .black
        return button
    }()
    lazy var stackForPopularCollectionView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelForPopularCollectionView, buttonForPopularCollectionView])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonForPopularCollectionView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setViews()
        setConstraints()
        }
    
    func setViews() {
        addSubview(stackForPopularCollectionView)
        stackForPopularCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackForPopularCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackForPopularCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackForPopularCollectionView.topAnchor.constraint(equalTo: topAnchor),
            stackForPopularCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    @objc func buttonTapped() {
//        let vc = CategoryViewController()
//        NavigationController.pushViewController(vc, animated: true)
    }
}
