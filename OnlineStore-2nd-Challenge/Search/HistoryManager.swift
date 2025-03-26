//
//  HistoryManager.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 20.03.2025.
//

import UIKit

class HistoryManager {
    private let maxSearchHistoryCount = 10
    private let searchHistoryKey = "searchHistory"
    
    private func getSearchHistory() -> [String] {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: searchHistoryKey) as? [String] ?? []
    }
    
    func saveSearchHistory(_ history: [String]) {
        let defaults = UserDefaults.standard
        defaults.set(history, forKey: searchHistoryKey)
    }
    
    func addSearchQuery(_ query: String) {
        var currentHistory = getSearchHistory()
        
        currentHistory.insert(query, at: 0)
        
        if currentHistory.count > maxSearchHistoryCount {
            currentHistory = Array(currentHistory.prefix(maxSearchHistoryCount))
        }
        
        saveSearchHistory(currentHistory)
    }
    
    func clearSearchHistory() {
        saveSearchHistory([])
    }
    
    func removeHistoryItem(at index: Int) {
        var history = getSearchHistory()
        history.remove(at: index)
        
    }
    
    func getAllSearchHistory() -> [String] {
        return getSearchHistory()
    }
}
