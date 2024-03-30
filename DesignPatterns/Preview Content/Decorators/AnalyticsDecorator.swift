//
//  AnalyticsDecorator.swift
//  DesignPatterns
//
//  Created by macbook abdul on 30/03/2024.
//

import Foundation
import SwiftUI

public class AnalyticsTracker {
    public init(){}
    func track(values:[String]){
        print(values)
    }
}
public class AnalyticsDecorator:ItemService{
    let decoratee:ItemService
    let analyticsTracker:AnalyticsTracker
    
    public init(decoratee: ItemService, analyticsTracker: AnalyticsTracker) {
        self.decoratee = decoratee
        self.analyticsTracker = analyticsTracker
    }
    public func loadItem() async -> [String] {
        let values = await decoratee.loadItem()
        analyticsTracker.track(values: values)
        return values
        
    }
}
public protocol ItemService {
    func loadItem() async ->  [String]
}

public class RemoteItemService:ItemService{
    public init(){}
    public func loadItem() async -> [String] {
       try? await Task.sleep(nanoseconds: 1)
        return ["error","success"]
    }
    
}
public class AnalyticsViewModel:ObservableObject {
    @Published var values = [String]()
    let itemService:ItemService
    public  init(itemService: ItemService) {
        self.itemService = itemService
    }
    
    func load() async {
        self.values = await itemService.loadItem()
    }
}

public struct AnalyticsView:View {
    @StateObject var vm: AnalyticsViewModel

     public var body: some View {
        List(vm.values, id: \.self) { datum in
            Text(datum)
        }
        .onAppear{
            Task{
                await vm.load()
            }
           
        }
    }
}

public class AnalyticsComposer {
    public static func instantiate(serive:ItemService) -> AnalyticsView {
//
//        let analyticsTracker = AnalyticsDecorator(decoratee: RemoteItemService(), analyticsTracker: AnalyticsTracker())
        let vm = AnalyticsViewModel(itemService: serive)
        return AnalyticsView(vm: vm)
    }
}

#Preview {
    AnalyticsComposer.instantiate(serive: AnalyticsDecorator(decoratee: RemoteItemService(), analyticsTracker: AnalyticsTracker()))
}
