//
//  HeaderHomeCollection.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit
class HeaderHomeCollectionView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderHomeCollection"
    lazy var labelForHomeCollectionView: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textColor = .black
        return label
    }()
    lazy var buttonForHomeCollectionView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.tintColor = .black
        return button
    }()
    lazy var stackForHomeCollectionView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelForHomeCollectionView, buttonForHomeCollectionView])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        }
    
    func setViews() {
        addSubview(stackForHomeCollectionView)
        stackForHomeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackForHomeCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackForHomeCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackForHomeCollectionView.topAnchor.constraint(equalTo: topAnchor),
            stackForHomeCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
