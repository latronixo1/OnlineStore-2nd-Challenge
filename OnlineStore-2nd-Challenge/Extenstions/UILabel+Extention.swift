//
//  UILabel+Extention.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 03.03.2025.
//

import UIKit

extension UILabel {
    
    static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
