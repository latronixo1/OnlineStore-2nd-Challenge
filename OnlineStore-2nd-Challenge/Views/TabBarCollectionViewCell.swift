//
//  TabBarCollectionViewCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 03.03.2025.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    
    private lazy var pointTabBarImage: UIImageView = {
        let element = UIImageView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {     //если она выбрана
                layer.borderWidth = 3
                layer.borderColor = #colorLiteral(red: 0.4426239431, green: 0.1398270428, blue: 0.4386208057, alpha: 1)
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init:(coder) не был реализован")
    }
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.9561659694, green: 0.9591339231, blue: 0.9530903697, alpha: 1)
        layer.cornerRadius = 10
        
        addSubview(pointTabBarImage)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            pointTabBarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            pointTabBarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            pointTabBarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
}
