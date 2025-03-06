//
//  UserDefaultsStorageKeys.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation
import UIKit

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

final class FavoriteManager {
    static let shared = FavoriteManager()
    
    private var favoriteProduct: [Product] = []
    private let defaults = UserDefaults.standard
    private let favoriteKey = UserDefaultsStorageKeys.favoriteProducts
    
    var favoriteArray: [Product] {
        get {
            return favoriteProduct
        }
        set {
            favoriteProduct = newValue
            saveProduct()
        }
    }
    
    private init() {
        loadProducts()
    }
    
    
    func addToFavorite(product: Product) {
        guard !isFavorite(product: product) else { return}
        favoriteProduct.append(product)
        saveProduct()
    }
    
    func removeFromFavorite(product: Product) {
        guard let index = favoriteProduct.firstIndex(of: product) else {return}
        favoriteProduct.remove(at: index)
        saveProduct()
    }
    
    func isFavorite(product: Product) -> Bool {
        favoriteProduct.contains(product)
    }
    
    private func saveProduct() {
        do {
            let encodeData = try JSONEncoder().encode(favoriteProduct)
            defaults.set(encodeData, forKey: favoriteKey.rawValue)
        } catch {
            print("Ошибка сохранения избранного продукта: \(error)")
        }
    }
    
    private func loadProducts() {
        guard let savedData = defaults.data(forKey: favoriteKey.rawValue) else { return }
        do {
            favoriteProduct = try JSONDecoder().decode([Product].self, from: savedData)
        } catch {
            print("Ошибка загрузки избранных товаров: \(error)")
        }
    }
}
