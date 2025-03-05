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
        let auth = UserDefaults.standard.bool(forKey: UserDefaultsStorageKeys.authIsTrue.label)
         window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: auth ? StartViewController() : TabBarController())
       //создаем панель вкладок
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        // Настраиваем иконки и заголовки
//        favoritesVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
//        categoriesVC.tabBarItem = UITabBarItem(title: "Категории", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
//        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
//        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        

    }

    

}

