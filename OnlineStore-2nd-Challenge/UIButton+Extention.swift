//
//  UIButton+extention.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 03.03.2025.
//

import UIKit

extension UIButton {
    
    static func makeButton(text: String = "", font: UIFont?, textColor: UIColor, cornerRadius: CGFloat, colorBackground: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.tintColor = colorBackground
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
