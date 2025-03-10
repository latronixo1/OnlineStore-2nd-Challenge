//
//  CartViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 05.03.2025.
//

import UIKit

class TestCartViewController: UIViewController {
    
    private lazy var checkoutButton = CustomButton(title: "Checkout", backgroundColor: UIColor(red: 0, green: 75/255, blue: 254/255, alpha: 1), textColor: .white, fontSize: FontSize.small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(checkoutButton)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ]
        )
    }
    
    @objc func checkoutButtonTapped() {
        let paymentVC = PaymentViewController()
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
}
