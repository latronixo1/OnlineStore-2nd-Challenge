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

//struct Category: Codable {
//    let title: String
//    let icon: String
//    var subcategories: [String]
//    var isExpanded: Bool
//    
//    static func categoriesFromProducts(_ products: [Product]) -> [Category] {
//        let uniqueCategories = Array(Set(products.map { $0.category }))
//        
//        return uniqueCategories.enumerated().map { index, categoryName in
//            let firstProduct = products.first { $0.category == categoryName }
//            
//            // Создаем подкатегории с номерами в зависимости от индекса категории
//            let startIndex = index * 4 + 1
//            let subcategories = (startIndex...(startIndex + 3)).map { "Подкатегория №\($0)" }
//            
//            return Category(
//                title: categoryName,
//                icon: firstProduct?.image ?? "",
//                subcategories: subcategories,
//                isExpanded: false
//            )
//        }
//    }
//}


struct Category: Codable {
    let title: String
    let icon: String
    var subcategories: [String]
    var isExpanded: Bool
    
    // Метод для получения кастомных подкатегорий на основе названия категории
    static func getCustomSubcategories(for category: String) -> [String] {
        switch category {
        case "men's clothing": // Первая категория
            return ["Верхняя одежда", "Брюки", "Джемперы", "Костюмы",
                    "Рубашки", "Пижамы", "Спецодежда", "Большие размеры"]
        case "electronics": // Вторая категория
            return ["Автоэлектроника", "Наушники", "Игровые консоли",
                    "Компьютеры", "Телефоны", "Телевизоры"]
        case "women's clothing": // Третья категория
            return ["Верхняя одежда", "Блузки", "Платья", "Комбинезоны",
                    "Юбки", "Халаты", "Туники", "Топы", "Офис", "Большие размеры"]
        case "jewelery": // Четвертая категория
            return ["Кольца", "Серьги", "Браслеты", "Подвески"]
        default:
            return []
        }
    }
    
    // Метод для получения кастомной иконки на основе индекса
    static func getCustomIcon(for category: String) -> String {
        switch category {
        case "men's clothing":
            return "mens"
        case "electronics":
            return "electronics"
        case "women's clothing":
            return "womens"
        case "jewelery":
            return "jewelery"
        default:
            return ""
        }
    }
}
