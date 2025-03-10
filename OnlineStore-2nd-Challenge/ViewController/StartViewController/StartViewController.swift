//
//  StartViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    let mainView: StartView = .init()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        mainView.getStartedBtton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(goToAuthorize), for: .touchUpInside)
        
    }
    @objc func getStarted() {
        let vc = CreatAccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToAuthorize() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
