//
//  CustomEditButton.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 08.03.2025.
//
import UIKit

final class CustomEditButton: UIButton {
    
    let button = UIButton()
    
    //MARK: - Init
    init(image: UIImage) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButton(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomEditButton {
    private func setupButton(_ image: UIImage) {
        setImage(UIImage(resource: .button), for: .normal)
    }
}
