//
//  UIImage+Extention.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 03.03.2025.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image", cornerRadius: CGFloat, heightAnchor: CGFloat, widthAnchor: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
