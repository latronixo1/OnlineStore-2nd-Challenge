//
//  TabBarView.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 03.03.2025.
//

import UIKit

class TabBarCollectionView: UICollectionView {
    
    private lazy var iconImage: UIImage = {
        let element = UIImage()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.distribution = .fill
        element.contentMode = .scaleToFill
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //встроенная переменная isSelected. При нажатии на ячейку она становится true
    override var isSelected: Bool {
        didSet {
            if isSelected {     //если она выбрана
                tintColor = .black
//                layer.borderWidth = 3
//                layer.borderColor = #colorLiteral(red: 0.4426239431, green: 0.1398270428, blue: 0.4386208057, alpha: 1)
            } else {
                tintColor = #colorLiteral(red: 0, green: 0.2980392157, blue: 1, alpha: 1)
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) не определен")
    }
    
    func setViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(<#T##view: UIView##UIView#>)
    }
    
    func setupConstraints() {
        
    }
}
