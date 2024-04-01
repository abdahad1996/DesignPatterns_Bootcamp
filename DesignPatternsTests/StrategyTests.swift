//
//  StrategyTests.swift
//  DesignPatternsTests
//
//  Created by macbook abdul on 31/03/2024.
//

import Foundation
import DesignPatterns
import XCTest

class StrategyTests: XCTestCase {
    func test_ViewModel_RemoteStrategy() async  {
        let (remoteStrategy,localStrategy) = makeSUT()
 
        let viewModel = StrategyViewModel(loader: remoteStrategy)
        
        await viewModel.loadData()
        
        XCTAssertEqual(viewModel.data,["remoteData1", "remoteData2"])
        
    }
    
    func test_ViewModel_localStrategy() async  {
        let (remoteStrategy,localStrategy) = makeSUT()
 
        let viewModel = StrategyViewModel(loader: localStrategy)
        
        await viewModel.loadData()
        
        XCTAssertEqual(viewModel.data,["localData1", "localData2"])


 
        
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (RemoteLoaderStrategy,LocalLoaderStrategy){
        
        let remoteStrategy = RemoteLoaderStrategy()
        trackForMemoryLeaks(remoteStrategy,file: file,line: line)

        let localStrategy = LocalLoaderStrategy()
        trackForMemoryLeaks(localStrategy,file: file,line: line)
 
        

        

        return (remoteStrategy,localStrategy)
    }
    
}
