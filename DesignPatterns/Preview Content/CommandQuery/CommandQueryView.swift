//
//  CommandQueryView.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//

import Foundation

import Foundation
import SwiftUI

struct CommandQueryView: View {
    @ObservedObject var viewModel: ItemListViewModel
    
    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
                
                HStack {
                    Button(action: viewModel.addItem) {
                        Text("Add Item")
                    }
                    .padding()
                    
                    Spacer()
                    
                    EditButton()
                        .padding()
                }
            }
            .navigationTitle("Items")
        }
    }
}

struct ViolatedCommandQueryView: View {
    @ObservedObject var viewModel: ViolatedItemListViewModel
    
    init(viewModel: ViolatedItemListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
                
                HStack {
                    Button(action: viewModel.addItem) {
                        Text("Add Item")
                    }
                    .padding()
                    
                    Spacer()
                    
                    EditButton()
                        .padding()
                }
            }
            .navigationTitle("Items")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
     static var previews: some View {
         let dataprovider = MockItemDataProvider()
         let viewModel = ItemListViewModel(dataProvider: dataprovider)
         dataprovider.delegate = viewModel
         
         
         let violatedDataProvider = ViolatedMockItemDataProvider()
         let violatedViewModel = ViolatedItemListViewModel(dataProvider: violatedDataProvider)
         
//         return CommandQueryView(viewModel: viewModel)
         return ViolatedCommandQueryView(viewModel: violatedViewModel)

    }
   
}
