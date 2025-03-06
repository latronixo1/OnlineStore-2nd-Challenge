//
//  CategoryModel.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 04.03.2025.
//

import Foundation

//struct Category {
//    let title: String
//    let icon: String
//    var subcategories: [String]?
//    var isExpanded: Bool
//    
//    static func mockData() -> [Category] {
//        return [
//            Category(title: "Clothing", icon: "clothing", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: true),
//            Category(title: "Shoes", icon: "shoes", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
//            Category(title: "Bags", icon: "bags", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
//            Category(title: "Lingerie", icon: "lingerie", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
//            Category(title: "Accessories", icon: "accessories", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false)
//        ]
//    }
//}

struct Category: Codable {
    let title: String
    let icon: String
    var subcategories: [String]?
    var isExpanded: Bool
    
    static func mockData() -> [Category] {
        // Получаем категории из UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: UserDefaultsStorageKeys.category.label),
           let categories = try? JSONDecoder().decode([Category].self, from: savedData) {
            return categories
        }
        
        // Если данных нет, возвращаем дефолтные значения
        return [
            Category(title: "Clothing", icon: "clothing", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Shoes", icon: "shoes", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Bags", icon: "bags", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Lingerie", icon: "lingerie", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Accessories", icon: "accessories", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false)
        ]
    }
}
