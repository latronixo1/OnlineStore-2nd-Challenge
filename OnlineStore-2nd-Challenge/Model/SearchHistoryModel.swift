//
//  SearchHistoryModel.swift
//  OnlineStore-2nd-Challenge
//
//  Created by Александр Семёнов on 03.03.2025.
//

struct SearchHistoryModel {
    private(set) var items: [String]
    
    mutating func addItem(_ item: String) {
        if !items.contains(item) {
            items.insert(item, at: 0)
        }
    }
    
    mutating func removeItem(at index: Int) {
        items.remove(at: index)
    }
    
    mutating func removeAllItems() {
        items.removeAll()
    }
    
    init(items: [String] = []) {
        self.items = items
    }
}
