//
//  ContentView.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//

import SwiftUI

//struct ContentView: View {
//    @ObservedObject var viewModel: ItemListViewModel
//    
//    init(viewModel: ItemListViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(viewModel.items, id: \.self) { item in
//                        Text(item)
//                    }
//                    .onDelete(perform: viewModel.deleteItem)
//                }
//                
//                HStack {
//                    Button(action: viewModel.addItem) {
//                        Text("Add Item")
//                    }
//                    .padding()
//                    
//                    Spacer()
//                    
//                    EditButton()
//                        .padding()
//                }
//            }
//            .navigationTitle("Items")
//        }
//    }
//}
//
//#Preview {
//    ContentView(viewModel:ItemListViewModel(dataProvider: MockItemDataProvider()))
//}
//
//protocol ItemDataProvider {
//    func loadItems() -> [String]
//    func deleteItem(at index: Int)
//}
//
//class MockItemDataProvider: ItemDataProvider {
//    private var items: [String] = ["Item 1", "Item 2", "Item 3"]
//    
//    func loadItems() -> [String] {
//        return items
//    }
//    
//    func deleteItem(at index: Int) {
//        guard index >= 0, index < items.count else { return }
//        items.remove(at: index)
//    }
//}
//class ItemListViewModel: ObservableObject {
//    @Published var items: [String] = []
//    private let dataProvider: ItemDataProvider
//    
//    init(dataProvider: ItemDataProvider) {
//        self.dataProvider = dataProvider
//        self.items = dataProvider.loadItems()
//    }
//    
//    func addItem() {
//        let newItem = "Item \(items.count + 1)"
//        items.append(newItem)
//    }
//    
//    func deleteItem(at index: IndexSet) {
//        guard let firstIndex = index.first else { return }
//        dataProvider.deleteItem(at: firstIndex)
//        items = dataProvider.loadItems()
//    }
//}
