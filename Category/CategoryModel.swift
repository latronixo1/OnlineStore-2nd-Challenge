//
//  CategoryModel.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 04.03.2025.
//

import Foundation

struct Category {
    let title: String
    let icon: String
    var subcategories: [String]?
    var isExpanded: Bool
    
    static func mockData() -> [Category] {
        return [
            Category(title: "Clothing", icon: "clothing_icon", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: true),
            Category(title: "Shoes", icon: "shoes_icon", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Bags", icon: "bags_icon", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Lingerie", icon: "lingerie_icon", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false),
            Category(title: "Accessories", icon: "accessories_icon", subcategories: ["Dresses", "Pants", "Skirts", "Shorts", "Jackets", "Hoodies", "Shirts", "Polo", "T-Shirts", "Tunics"], isExpanded: false)
        ]
    }
}
