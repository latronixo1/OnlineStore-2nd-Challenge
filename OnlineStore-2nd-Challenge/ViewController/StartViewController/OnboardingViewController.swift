//
//  OnboardingViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Barnabas Bala on 04.03.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    //let backgroundImage = UIImageView()
    
    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
       // backgroundImage.image = UIImage(named: backgroundImageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}
    extension OnboardingViewController {
        
        func style() {
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 20
            stackView.clipsToBounds = true
           
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
            subtitleLabel.textAlignment = .center
            
            subtitleLabel.numberOfLines = 0
        }
    
        func layout() {
               stackView.addArrangedSubview(imageView)
               stackView.addArrangedSubview(titleLabel)
               stackView.addArrangedSubview(subtitleLabel)
               
               view.addSubview(stackView)
               
               NSLayoutConstraint.activate([
                   stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                   
                   imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                   
                   subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
                   view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
               ])
           }
       }


