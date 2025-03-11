//
//  HeaderHomeCollection.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit
class HeaderHomeCollectionView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderHomeCollection"

    let labelForHomeCollectionView: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textColor = .black
        return label
    }()

    let buttonForHomeCollectionView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.tintColor = .black
        return button
    }()

    lazy var stackForHomeCollectionView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.labelForHomeCollectionView, self.buttonForHomeCollectionView])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(stackForHomeCollectionView)
        stackForHomeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackForHomeCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackForHomeCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackForHomeCollectionView.topAnchor.constraint(equalTo: topAnchor),
            stackForHomeCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
