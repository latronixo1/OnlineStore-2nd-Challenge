//
//  HomeCategoryCell.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 04.03.2025.
//

import UIKit

class HomeCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCategoryCell"
    let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let secondImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let fourthImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let labelOfCategory: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    let quantityOfProducts: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    let stackOfCatefory: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
        }
    func setView(){
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)
        addSubview(fourthImageView)
        stackOfCatefory.addArrangedSubview(labelOfCategory)
        stackOfCatefory.addArrangedSubview(quantityOfProducts)
        addSubview(stackOfCatefory)
        
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        secondImageView.translatesAutoresizingMaskIntoConstraints = false
        thirdImageView.translatesAutoresizingMaskIntoConstraints = false
        fourthImageView.translatesAutoresizingMaskIntoConstraints = false
        stackOfCatefory.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            firstImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            firstImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            
            secondImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            secondImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            secondImageView.leftAnchor.constraint(equalTo: firstImageView.rightAnchor, constant: 6),
            
            thirdImageView.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: 6),
            thirdImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            
            fourthImageView.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 6),
            fourthImageView.leftAnchor.constraint(equalTo: thirdImageView.leftAnchor, constant: 6),
            fourthImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 6),
            
            stackOfCatefory.topAnchor.constraint(equalTo: fourthImageView.bottomAnchor, constant: 6),
            stackOfCatefory.leftAnchor.constraint(equalTo: leftAnchor, constant: 6),
            stackOfCatefory.rightAnchor.constraint(equalTo: rightAnchor, constant: 6)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
