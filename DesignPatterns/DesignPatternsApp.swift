//
//  DesignPatternsApp.swift
//  DesignPatterns
//
//  Created by macbook abdul on 28/03/2024.
//
import SwiftUI

@main
struct DesignPatternsApp: App {
    var body: some Scene {
        WindowGroup {
            CommandQueryView(viewModel:ItemListViewModel(dataProvider: MockItemDataProvider()))
        }
    }
}
