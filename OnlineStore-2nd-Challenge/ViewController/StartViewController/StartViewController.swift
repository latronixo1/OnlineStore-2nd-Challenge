//
//  StartViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

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
    //MARK: NAVIGATION
    @objc func getStarted() {
        print("нажал на кнопу")
        let vc = CreatAccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToAuthorize() {
        print("нажал на кнопу")
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    
}
