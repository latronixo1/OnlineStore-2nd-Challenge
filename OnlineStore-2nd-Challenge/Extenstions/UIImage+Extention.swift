//
//  UIImage+Extention.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 03.03.2025.
//

import UIKit

extension UIImageView {
    static func makeImage(named imageName: String = "image",
                          cornerRadius: CGFloat,
                          heightAnchor: CGFloat,
                          widthAnchor: CGFloat,
                          border: Bool,
                          shadow: Bool) -> UIImageView {
        let imageView = UIImageView()
        let containerView = UIView()
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.addSubview(imageView)
        containerView.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: widthAnchor)
        ])
        
        if border {
            imageView.layer.borderWidth = 5
            imageView.layer.borderColor = UIColor.white.cgColor
        }
        
        if shadow {
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowOffset = CGSize(width: 4, height: 4)
            containerView.layer.shadowRadius = 5
            //containerView.layer.masksToBounds = false
            
            // Установка пути тени
            containerView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: widthAnchor, height: heightAnchor), cornerRadius: cornerRadius).cgPath
        }
        
        return imageView
    }
}
