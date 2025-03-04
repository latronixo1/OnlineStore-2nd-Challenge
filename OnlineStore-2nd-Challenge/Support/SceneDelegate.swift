//
//  SceneDelegate.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 02.03.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let auth = UserDefaults.standard.bool(forKey: UserDefaultsStorageKeys.authIsTrue.label) //Добавить реализацию что был пропуск экрана, если пользователь авторизирован
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window?.makeKeyAndVisible()
    }

}

