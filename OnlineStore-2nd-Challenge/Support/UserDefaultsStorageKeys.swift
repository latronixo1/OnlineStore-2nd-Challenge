//
//  UserDefaultsStorageKeys.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    func saveFavoriteProducts(_ products: [Product]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: UserDefaultsStorageKeys.favoriteProducts.rawValue)
            print("Отлично, данные сохранены в UserDefaults")
        } catch {
            print("Ошибка при сохранении в UserDefaults: \(error)")
        }
    }
    
    func getFavoriteProducts() -> [Product]? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsStorageKeys.favoriteProducts.rawValue) else {
            return nil
        }
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print("Ошибка при получении из UserDefaults: \(error)")
            return nil
        }
    }
    
    func searchFavoriteItem(_ idProduct: Int) -> Product? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsStorageKeys.favoriteProducts.rawValue) else { return nil }
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products.first { $0.id == idProduct }
        } catch {
            print("Ошибка при получении из UserDefaults: \(error)")
            return nil
        }
    }
    
    func addFavoriteItem(_ product: Product) {
        var favoriteProducts = getFavoriteProducts() ?? []
        if !favoriteProducts.contains(where: { $0.id == product.id }) {
            favoriteProducts.append(product)
            saveFavoriteProducts(favoriteProducts)
            print("Товар успешно добавлен в избранное")
        } else {
            print("Товар уже есть в избранном")
        }
    }
    
    func deleteFavoriteItem(_ idProduct: Int) {
        guard var data = getFavoriteProducts() else { return }
        let initialCount = data.count
        data = data.filter { $0.id != idProduct }
        if data.count < initialCount {
            saveFavoriteProducts(data)
            print("Товар успешно удален из избранного")
        } else {
            print("Товар не найден в избранном")
        }
    }
}

// MARK: KEYSforUSerDefaults

enum UserDefaultsStorageKeys: String {
    case name
    case authIsTrue
    case favoriteProducts
    case category
    var label: String {
        switch self {
        case .name: return "Name"
        case .authIsTrue: return "AuthIsTrue"
        case .favoriteProducts: return "FavoriteProducts"
        case .category: return "Category"
        }
    }
}

