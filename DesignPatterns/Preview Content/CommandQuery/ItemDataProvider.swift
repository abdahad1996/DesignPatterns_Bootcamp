//
//  ItemDataProvider.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//

import Foundation

protocol ItemDataProvider {
    func loadItems() -> [String]
}
protocol ItemDataDeleter {
    func deleteItem(at index: Int)
}
