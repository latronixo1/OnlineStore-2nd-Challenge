//
//  HomePopularCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 06.03.2025.
//

import Foundation
import UIKit

class HomePopularCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeopularCell"
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let discriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
        
        
    }
    
    func setView(){
        containerView.addSubview(productImageView)
        containerView.addSubview(discriptionLabel)
        containerView.addSubview(priceLabel)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func setConstraint() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
