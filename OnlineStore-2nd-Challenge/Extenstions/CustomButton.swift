//
//  CustomButton.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 03.03.2025.
//

import UIKit

enum FontSize {
    case big
    case small
}

final class CustomButton: UIButton {
    
    //MARK: - Init
    init(title: String, backgroundColor: UIColor, textColor: UIColor, fontSize: FontSize) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButton(title, backgroundColor, textColor, fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton {
    private func setupButton(_ title: String, _ backgroundColor: UIColor,  _ textColor: UIColor, _ fontSize: FontSize) {
        
        setTitle(title, for: .normal)
        layer.masksToBounds = false
        self.backgroundColor = backgroundColor
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            layer.cornerRadius = 12
        case .small:
            titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            layer.cornerRadius = 4
        }
    }
}

