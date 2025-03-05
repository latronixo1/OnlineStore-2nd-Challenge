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
        
        //создаем для каждой вкладки свой NavigationController (они будут работать внутри своих вкладок), в качестве корневого вьюконтроллера нужно установить тот, который будет открываться по умолчанию
//        let registerVC = UINavigationController(rootViewController: CreatAccountViewController())
//        let loginVC = UINavigationController(rootViewController: LoginViewController())
        
        
        
        window = UIWindow(windowScene: windowScene)
        //window?.rootViewController = UINavigationController(rootViewController: auth ? StartViewController() : HomeViewController())
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        //создаем NavigationController для вкладки Home
        func createHomeViewController() -> UINavigationController {
            let VC = CreatAccountViewController()
            VC.title = "Home"   //Заголовок экрана (а не вкладки)
            VC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)   //настраиваем кнопку
            return UINavigationController(rootViewController: VC)
        }

        //создаем NavigationController для вкладки Wishlist
        func createWishlistViewController() -> UINavigationController {
            let VC = LoginViewController()
            VC.title = "Wishlist"   //Заголовок экрана (а не вкладки)
            VC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)   //настраиваем кнопку
            return UINavigationController(rootViewController: VC)
        }

        func createTabBarController() -> UITabBarController {
            //создаем панель вкладок
            let tabBarController = UITabBarController()

            //UITabBar.appearance().backgroundColor = .systemBlue
            //помещаем в панель вкладок навигационные контролллеры
            tabBarController.viewControllers = [createHomeViewController(), createWishlistViewController()]

            return tabBarController
        }


        // Настраиваем иконки и заголовки
//        favoritesVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
//        categoriesVC.tabBarItem = UITabBarItem(title: "Категории", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
//        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
//        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

        

    }

    

}

