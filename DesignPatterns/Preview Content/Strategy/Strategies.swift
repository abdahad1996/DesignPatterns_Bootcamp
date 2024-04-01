//
//  Strategies.swift
//  DesignPatterns
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation

public protocol LoaderStrategy {
    func load() async -> [String]
}

public class RemoteLoaderStrategy:LoaderStrategy{
    public init(){}
    public func load() async -> [String]{
        //api
        try? await Task.sleep(nanoseconds: 5)
        let values = ["remoteData1","remoteData2"]
        return values
    }
}

public class LocalLoaderStrategy:LoaderStrategy{
    public init(){}
    public func load() async -> [String] {
        //cache work
        try? await Task.sleep(nanoseconds: 5)
        let values = ["localData1","localData2"]
        return values
         
    }
}

public class StrategyViewModel{
    let loader:LoaderStrategy
    public var data = [String]()
    
    public init(loader: LoaderStrategy) {
        self.loader = loader
    }
    
    public func loadData() async {
      let values = await loader.load()
      self.data = values
    }
}
