//
//  CommandQuery.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//
import SwiftUI

class ViolatedMockItemDataProvider: ItemDataProvider {
    private var items: [String] = ["Item 1", "Item 2", "Item 3"]
    
    func loadItems() -> [String] {
        return items
    }
    
    func deleteItem(at index: Int) {
        guard index >= 0, index < items.count else { return }
        items.remove(at: index)
    }
}

import Foundation

class ViolatedItemListViewModel: ObservableObject {
    @Published var items: [String] = []
    private let dataProvider: ViolatedMockItemDataProvider
    
    init(dataProvider: ViolatedMockItemDataProvider) {
        self.dataProvider = dataProvider
        self.items = dataProvider.loadItems()
    }
    
    func addItem() {
        let newItem = "Item \(items.count + 1)"
        items.append(newItem)
    }
    
    func deleteItem(at index: IndexSet) {
        guard let firstIndex = index.first else { return }
        dataProvider.deleteItem(at: firstIndex)
        items = dataProvider.loadItems()
    }
}
