//
//  UserDefaultsStorageKeys.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Евгений on 03.03.2025.
//

import Foundation
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

