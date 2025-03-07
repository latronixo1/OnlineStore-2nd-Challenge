//
//  TabBarViewController.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Валентин Картошкин on 05.03.2025.
//

import UIKit

//панель вкладок
final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        case home
        case wishlist
        case categories
        case cart
        case settings

        var title: String {
            switch self {
            case .home: return "Home"
            case .wishlist: return "Wishlist"
            case .categories: return "Categories"
            case .cart: return "Cart"
            case .settings: return "Settings"
            }
        }
        var iconName: String {
            switch self {
            case .home: return "house"
            case .wishlist: return "heart"
            case .categories: return "text.page"
            case .cart: return "cart"
            case .settings: return "person"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(TabBar(), forKey: "tabBar")   //заменяем стандартный UITabBar на наш кастомный (ради индикатора)
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.home, .wishlist, .categories, .cart, .settings]
        self.tabBar.backgroundColor = .white
        //помещаем в панель вкладок (в свойство viewControllers) массив навигационных контролллеров
        self.viewControllers = dataSource.map{
            switch $0 {
            case .home: return self.wrappedInNavigationController(with: HomeViewController(), title: $0.title)
            case .wishlist: return self.wrappedInNavigationController(with: WishlistViewController(), title: $0.title)
            case .categories: return self.wrappedInNavigationController(with: CategoryViewController(), title: $0.title)
            case .cart: return self.wrappedInNavigationController(with: TestCartViewController(), title: $0.title)
            case .settings: return self.wrappedInNavigationController(with: TestSettingsViewController(), title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach{
            $1.tabBarItem.title = nil
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
            $1.tabBarItem.tag = $0
        }
        
        //настраиваем цвет иконок
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.iconColor = #colorLiteral(red: 0, green: 0.2947360277, blue: 0.9967841506, alpha: 1)
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        UITabBar.appearance().standardAppearance = appearance
    }
    
    //создаем для каждой вкладки свой NavigationController (они будут работать внутри своих вкладок), в качестве корневого вьюконтроллера нужно установить тот, который будет открываться по умолчанию
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
        return UINavigationController(rootViewController:  with)
    }
    
    
}

