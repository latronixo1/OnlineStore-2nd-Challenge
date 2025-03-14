//
//  UserDefaultsStorageKeys.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation

// MARK: KEYSforUSerDefaults

enum UserDefaultsStorageKeys: String {
    case name
    case email
    case password
    case authIsTrue
    case favoriteProducts 
    case category
    case gender
    case cart //корзина
    var label: String {
        switch self {
        case .name: return "Name"
        case .email: return "Email"
        case .password: return "Password"
        case .authIsTrue: return "AuthIsTrue"
        case .favoriteProducts: return "FavoriteProducts"
        case .category: return "Category"
        case .gender: return "Gender"
        case .cart: return "Cart"
        }
    }
}


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let userKey = "savedUser"
    private let productsKey = "savedProducts"
    
    
    // Сохранение User
    func saveUser(_ user: UserData) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    // Загрузка User
    func loadUser() -> UserData? {
        if let user = UserDefaults.standard.data(forKey: userKey),
           let userData = try? JSONDecoder().decode(UserData.self, from: user) {
            return userData
        }
        return nil
    }
    
    // Удаление User
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
    
    // Сохранение массива Product
    func saveProducts(_ products: [Product]) {
        if let encoded = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(encoded, forKey: productsKey)
        }
    }
    
    // Загрузка массива Product
    func loadProducts() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: productsKey) else { return [] }
        return (try? JSONDecoder().decode([Product].self, from: data)) ?? []
    }
    
    // Удаление всех сохранённых продуктов
    func deleteProducts() {
        UserDefaults.standard.removeObject(forKey: productsKey)
    }
    
    
    //MARK: - Сохранение массив продуктов по ключу
    func saveProducts(_ products: [Product], _ forKey: UserDefaultsStorageKeys) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: forKey.label)
            print("Отлично, данные сохранены в UserDefaults по ключу \(forKey)")
        } catch {
            print("Ошибка при сохранении в UserDefaults: \(error)")
        }
    }
    //MARK: - Получение массив продуктов по ключу
    func getProducts(_ category: UserDefaultsStorageKeys) -> [Product]? {
        guard let data = UserDefaults.standard.data(forKey: category.label) else {
            return nil
        }
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print("Ошибка при получении из UserDefaults: \(error)")
            return nil
        }
    }
    //MARK: - Поиск проукта по Id
    func searchFavoriteItem(_ idProduct: Int, _ category: UserDefaultsStorageKeys) -> Product? {
        guard let data = UserDefaults.standard.data(forKey: category.label) else { return nil }
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products.first { $0.id == idProduct }
        } catch {
            print("Ошибка при получении из UserDefaults: \(error)")
            return nil
        }
    }
    //MARK: - Добавление продукта в категорию
    func addItem(_ product: Product, _ category: UserDefaultsStorageKeys) {
        var products = self.getProducts(category) ?? []
        if !products.contains(where: { $0.id == product.id }) {
            products.append(product)
            self.saveProducts(products, category)
            print("Товар успешно добавлен в избранное")
        } else {
            print("Товар уже есть в избранном")
        }
    }
    //MARK: - Удаление продукта в категории по id
    func deleteItem(_ idProduct: Int, _ category: UserDefaultsStorageKeys) {
        guard var data = self.getProducts(category) else { return }
        let initialCount = data.count
        data = data.filter { $0.id != idProduct }
        if data.count < initialCount {
            self.saveProducts(data, category)
            print("Товар успешно удален из избранного")
        } else {
            print("Товар не найден в избранном")
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
    
    func userDefaultsExists(key: String) -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: key) else {
            return false
        }
        return true
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
