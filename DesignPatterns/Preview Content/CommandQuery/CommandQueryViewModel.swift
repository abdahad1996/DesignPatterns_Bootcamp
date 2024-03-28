//
//  CommandQuery.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//

import Foundation
import SwiftUI

class MockItemDataProvider: ItemDataProvider,ItemDataDeleter {
    private var items: [String] = ["Item 1", "Item 2", "Item 3"]
    weak var delegate: ItemDataProviderDelegate?
    
    
    func loadItems() -> [String] {
        return items
    }
    
    func deleteItem(at index: Int) {
        guard index >= 0, index < items.count else { return }
        items.remove(at: index)
        delegate?.itemsDidChange(items)
    }
}

protocol ItemDataProviderDelegate: AnyObject {
    func itemsDidChange(_ items:[String])
}

class ItemListViewModel: ObservableObject, ItemDataProviderDelegate {
    
    
    
    @Published var items: [String] = []
    typealias facade = ItemDataProvider & ItemDataDeleter
    private let dataProvider: facade
    
    
    init(dataProvider: facade) {
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
        
    }
    
    func itemsDidChange(_ items: [String]) {
        self.items = items
    }
}
