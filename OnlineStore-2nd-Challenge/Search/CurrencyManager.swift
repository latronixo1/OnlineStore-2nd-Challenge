//
//  CurrencyManager.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 20.03.2025.
//

import UIKit

final class CurrencyManager {
    static let shared = CurrencyManager()
    
    private let currencyKey = "selectedCurrency"
    
    func getCurrency() -> String {
        return UserDefaults.standard.string(forKey: currencyKey) ?? "$"
    }
    
    func saveCurrency(_ currency: String) {
        UserDefaults.standard.set(currency, forKey: currencyKey)
    }
}


extension Notification.Name {
    static let currencyDidChange = Notification.Name("currencyDidChange")
}
